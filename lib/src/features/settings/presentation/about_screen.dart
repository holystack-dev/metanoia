import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Widget _referenceItem(ThemeData theme, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Icon(
              Icons.circle,
              size: 6,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              url,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.about)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 48),
            // App Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    isDark
                        ? 'assets/icon/foreground.png'
                        : 'assets/images/applogo.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // App Name
            Text(
              l10n.appTitle,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            // Version
            Text(
              '${l10n.version} 1.0.0',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 48),
            // Made with love
            Text(l10n.madeWithLove, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            // Subtle disclaimer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                l10n.appDisclaimer,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.7,
                  ),
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            // Website Link
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n.website),
              subtitle: const Text('holystack.dev/metanoia'),
              trailing: const Icon(Icons.open_in_new, size: 20),
              onTap: () => _launchUrl(AppUrls.website),
            ),
            const Divider(),
            // Privacy Policy
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: Text(l10n.privacyPolicy),
              trailing: const Icon(Icons.open_in_new, size: 20),
              onTap: () => _launchUrl(AppUrls.privacyPolicy),
            ),
            const Divider(),
            // Source Code (GitHub)
            ListTile(
              leading: const Icon(Icons.code),
              title: Text(l10n.sourceCode),
              subtitle: const Text('github.com/holystack-dev/metanoia'),
              trailing: const Icon(Icons.open_in_new, size: 20),
              onTap: () => _launchUrl(AppUrls.githubRepo),
            ),
            const Divider(),
            // Licenses
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: const Text('Open Source Licenses'),
              trailing: const Icon(Icons.chevron_right),
              onTap:
                  () => showLicensePage(
                    context: context,
                    applicationName: l10n.appTitle,
                    applicationVersion: '1.0.0',
                    applicationIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/applogo.png',
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
            ),
            const SizedBox(height: 32),
            // Content References
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.menu_book_rounded,
                            size: 20,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.contentReferences,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _referenceItem(theme, 'vatican.va'),
                      _referenceItem(theme, 'ewtn.com'),
                      _referenceItem(
                        theme,
                        'web.archive.org/web/20171217131827/http://www.solemncharge.com/',
                      ),
                      _referenceItem(theme, 'mountcarmelretreatcentre.org'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
