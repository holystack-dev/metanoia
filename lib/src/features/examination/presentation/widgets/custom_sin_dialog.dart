import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:drift/drift.dart' as drift;

class CustomSinDialog extends ConsumerStatefulWidget {
  final UserCustomSin? existingSin;
  final String? originalQuestionId;
  final String? initialText;
  final String? initialCommandmentCode;

  const CustomSinDialog({
    super.key,
    this.existingSin,
    this.originalQuestionId,
    this.initialText,
    this.initialCommandmentCode,
  });

  @override
  ConsumerState<CustomSinDialog> createState() => _CustomSinDialogState();
}

class _CustomSinDialogState extends ConsumerState<CustomSinDialog> {
  late TextEditingController _sinTextController;
  late TextEditingController _noteController;
  String? _selectedCommandmentCode;
  bool _isLoading = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _sinTextController = TextEditingController(
      text: widget.existingSin?.sinText ?? widget.initialText ?? '',
    );
    _noteController = TextEditingController(
      text: widget.existingSin?.note ?? '',
    );
    _selectedCommandmentCode = widget.existingSin?.commandmentCode ??
        widget.initialCommandmentCode;
    _hasText = _sinTextController.text.trim().isNotEmpty;
    _sinTextController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _sinTextController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    _sinTextController.removeListener(_onTextChanged);
    _sinTextController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final examinationDataAsync = ref.watch(examinationDataProvider);

    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.existingSin != null
                        ? Icons.edit
                        : Icons.add_circle_outline,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.existingSin != null
                          ? l10n.editCustomSin
                          : l10n.addCustomSin,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                    color: theme.colorScheme.onPrimaryContainer,
                    tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Sin description field
                    TextField(
                      controller: _sinTextController,
                      decoration: InputDecoration(
                        labelText: l10n.sinDescription,
                        hintText: l10n.sinDescriptionHint,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.description),
                      ),
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 16),

                    // Optional note field
                    TextField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        labelText: l10n.optionalNote,
                        hintText: l10n.optionalNoteHint,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.sticky_note_2_outlined),
                      ),
                      maxLines: 2,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 16),

                    // Commandment selection
                    if (widget.originalQuestionId ==
                        null) // Don't show for edited questions
                      examinationDataAsync.when(
                        data: (commandmentsWithQuestions) {
                          return DropdownButtonFormField<String?>(
                            value: _selectedCommandmentCode,
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: l10n.selectCommandment,
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.bookmark_outline),
                            ),
                            items: [
                              DropdownMenuItem<String?>(
                                value: null,
                                child: Text(
                                  l10n.noCommandment,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Only show commandments 1-11 (Ten Commandments + Precepts)
                              ...commandmentsWithQuestions
                                  .where((c) =>
                                      c.commandment != null &&
                                      c.commandment!.commandmentNo <= 11)
                                  .map((c) {
                                return DropdownMenuItem<String?>(
                                  value: c.commandment!.code,
                                  child: Text(
                                    c.commandment!.customTitle ??
                                        c.commandment!.content,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                );
                              }),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedCommandmentCode = value;
                              });
                            },
                          );
                        },
                        loading:
                            () => const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                  ],
                ),
              ),
            ),

            // Actions
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed:
                        _isLoading ? null : () => Navigator.of(context).pop(),
                    child: Text(l10n.cancel),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _isLoading || !_hasText ? null : _saveSin,
                    child:
                        _isLoading
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : Text(
                              widget.existingSin != null
                                  ? l10n.updateButton
                                  : l10n.addButton,
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveSin() async {
    final l10n = AppLocalizations.of(context)!;
    final sinText = _sinTextController.text.trim();

    if (sinText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.sinDescriptionRequired)));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final companion = UserCustomSinsCompanion(
        sinText: drift.Value(sinText),
        note: drift.Value(
          _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
        ),
        commandmentCode: drift.Value(_selectedCommandmentCode),
        originalQuestionId: drift.Value(widget.originalQuestionId),
      );

      Navigator.of(context).pop(companion);
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${l10n.error}: $e')));
      }
    }
  }
}
