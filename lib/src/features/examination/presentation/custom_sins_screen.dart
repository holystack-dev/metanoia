import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/widgets/empty_state.dart';
import 'package:confessionapp/src/features/examination/data/user_custom_sins_repository.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/custom_sin_dialog.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomSinsScreen extends ConsumerStatefulWidget {
  const CustomSinsScreen({super.key});

  @override
  ConsumerState<CustomSinsScreen> createState() => _CustomSinsScreenState();
}

class _CustomSinsScreenState extends ConsumerState<CustomSinsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.customSins)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCustomSinDialog(),
        icon: const Icon(Icons.add),
        label: Text(l10n.addCustomSin),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.searchCustomSins,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          // Custom sins list
          Expanded(
            child: FutureBuilder<Map<String?, List<UserCustomSin>>>(
              future:
                  ref
                      .read(userCustomSinsRepositoryProvider)
                      .getCustomSinsGroupedByCommandment(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: theme.colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text('${l10n.error}: ${snapshot.error}'),
                      ],
                    ),
                  );
                }

                final groupedSins = snapshot.data ?? {};

                if (groupedSins.isEmpty) {
                  return EmptyState(
                    icon: Icons.note_add_outlined,
                    title: l10n.noCustomSins,
                    subtitle: l10n.noCustomSinsDesc,
                  ).animate().fadeIn(duration: 300.ms).scale(delay: 100.ms);
                }

                return FutureBuilder<List<CommandmentWithQuestions>>(
                  future: ref.read(examinationDataProvider.future),
                  builder: (context, cmdSnapshot) {
                    final commandments = cmdSnapshot.data ?? [];
                    final commandmentMap = {
                      for (var c in commandments)
                        if (c.commandment != null)
                          c.commandment!.code: c.commandment,
                    };

                    // Filter sins by search query
                    final filteredGroupedSins =
                        <String?, List<UserCustomSin>>{};
                    for (final entry in groupedSins.entries) {
                      final filteredSins =
                          entry.value.where((sin) {
                            return _searchQuery.isEmpty ||
                                sin.sinText.toLowerCase().contains(
                                  _searchQuery,
                                ) ||
                                (sin.note?.toLowerCase().contains(
                                      _searchQuery,
                                    ) ??
                                    false);
                          }).toList();

                      if (filteredSins.isNotEmpty) {
                        filteredGroupedSins[entry.key] = filteredSins;
                      }
                    }

                    if (filteredGroupedSins.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.noResults,
                              style: theme.textTheme.titleLarge,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredGroupedSins.length,
                      itemBuilder: (context, index) {
                        final code = filteredGroupedSins.keys.elementAt(index);
                        final sins = filteredGroupedSins[code]!;
                        final commandment =
                            code != null ? commandmentMap[code] : null;

                        return _buildSinGroup(
                          context,
                          commandment?.customTitle ??
                              commandment?.content ??
                              l10n.noCommandment,
                          sins,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSinGroup(
    BuildContext context,
    String title,
    List<UserCustomSin> sins,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...sins.map((sin) => _buildSinCard(context, sin)),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSinCard(BuildContext context, UserCustomSin sin) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            sin.originalQuestionId != null ? Icons.edit : Icons.note_add,
            color: theme.colorScheme.onPrimaryContainer,
            size: 20,
          ),
        ),
        title: Text(sin.sinText),
        subtitle:
            sin.note != null
                ? Text(
                  sin.note!,
                  style: theme.textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
                : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (sin.originalQuestionId != null)
              Tooltip(
                message: l10n.customVersion,
                child: Icon(
                  Icons.auto_awesome,
                  size: 16,
                  color: theme.colorScheme.secondary,
                ),
              ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'edit') {
                  _showCustomSinDialog(existingSin: sin);
                } else if (value == 'delete') {
                  _confirmDelete(sin);
                }
              },
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          const Icon(Icons.edit),
                          const SizedBox(width: 8),
                          Text(l10n.editCustomSin),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: theme.colorScheme.error),
                          const SizedBox(width: 8),
                          Text(
                            l10n.deleteCustomSin,
                            style: TextStyle(color: theme.colorScheme.error),
                          ),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 200.ms).slideX(begin: -0.1, end: 0);
  }

  Future<void> _showCustomSinDialog({UserCustomSin? existingSin}) async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<UserCustomSinsCompanion>(
      context: context,
      builder: (context) => CustomSinDialog(existingSin: existingSin),
    );

    if (result != null && mounted) {
      try {
        final repository = ref.read(userCustomSinsRepositoryProvider);

        if (existingSin != null) {
          await repository.updateCustomSin(existingSin.id, result);
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.customSinUpdated)));
          }
        } else {
          await repository.insertCustomSin(result);
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.customSinAdded)));
          }
        }

        // Refresh the screen
        setState(() {});
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('${l10n.error}: $e')));
        }
      }
    }
  }

  Future<void> _confirmDelete(UserCustomSin sin) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(l10n.deleteCustomSin),
            content: Text(l10n.deleteCustomSinConfirm),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                child: Text(l10n.deleteButton),
              ),
            ],
          ),
    );

    if (confirmed == true && mounted) {
      try {
        await ref
            .read(userCustomSinsRepositoryProvider)
            .deleteCustomSin(sin.id);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.customSinDeleted)));
          setState(() {});
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('${l10n.error}: $e')));
        }
      }
    }
  }
}
