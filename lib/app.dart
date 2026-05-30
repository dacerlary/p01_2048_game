import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game.dart';
import 'managers/app_flow.dart';
import 'screens/onboarding_screen.dart';
import 'screens/splash_screen.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool _splashDone = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() => _splashDone = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final flow = context.watch<AppFlowManager>();

    if (flow.isLoading || !_splashDone) {
      return const SplashScreen();
    }

    if (!flow.hasSeenOnboarding) {
      return const OnboardingScreen();
    }

    return const Game();
  }
}
