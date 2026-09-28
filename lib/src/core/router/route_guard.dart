import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';

/// Routes that must not be reachable before a PIN is set.
///
/// Each shows the user's own data, or (settings) can delete it.
const sensitiveRoutes = [
  '/examine',
  '/confess',
  '/settings',
  '/journal',
];

/// The redirect the router should apply, or null to allow the navigation.
///
/// A pure function so the onboarding x PIN matrix can be tested. A deep link
/// that slips past it reaches the user's data without a PIN.
String? resolveRedirect({
  required bool onboardingCompleted,
  required AuthStatus authStatus,
  required String location,
}) {
  final isOnOnboardingPage = location == '/onboarding';
  final isOnPinSetupPage = location == '/pin-setup';

  if (!onboardingCompleted && !isOnOnboardingPage) {
    return '/onboarding';
  }

  if (onboardingCompleted && isOnOnboardingPage) {
    return '/';
  }

  if (!onboardingCompleted || isOnPinSetupPage) return null;

  final isPinDeferred =
      authStatus == AuthStatus.pinSetupDeferred ||
      authStatus == AuthStatus.uninitialized;
  if (!isPinDeferred) return null;

  final isSensitive = sensitiveRoutes.any(location.startsWith);
  if (!isSensitive) return null;

  // Carry the intended destination, so PIN setup can hand the user back to it.
  return '/pin-setup?redirect=${Uri.encodeComponent(location)}';
}
