import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'main_shell.dart';
import 'onboarding_screen.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

enum _AppRoute { loading, onboarding, login, main }

class _AppRouterState extends State<AppRouter> {
  final StorageService _storage = StorageService();
  _AppRoute _route = _AppRoute.loading;

  @override
  void initState() {
    super.initState();
    _resolveRoute();
  }

  Future<void> _resolveRoute() async {
    final onboardingDone = await _storage.hasCompletedOnboarding();
    final agreedToTerms = await _storage.hasAgreedToTerms();

    if (!mounted) return;

    setState(() {
      if (!onboardingDone) {
        _route = _AppRoute.onboarding;
      } else if (!agreedToTerms) {
        _route = _AppRoute.login;
      } else {
        _route = _AppRoute.main;
      }
    });
  }

  void _onOnboardingComplete() {
    setState(() => _route = _AppRoute.login);
  }

  void _onLoginComplete() {
    setState(() => _route = _AppRoute.main);
  }

  void _onLogout() {
    setState(() => _route = _AppRoute.login);
  }

  @override
  Widget build(BuildContext context) {
    return switch (_route) {
      _AppRoute.loading => const Scaffold(
          backgroundColor: AppTheme.white,
          body: Center(
            child: CircularProgressIndicator(color: AppTheme.black, strokeWidth: 2),
          ),
        ),
      _AppRoute.onboarding => OnboardingScreen(onComplete: _onOnboardingComplete),
      _AppRoute.login => LoginScreen(onComplete: _onLoginComplete),
      _AppRoute.main => MainShell(onLogout: _onLogout),
    };
  }
}
