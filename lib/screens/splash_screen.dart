import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../components/app_title.dart';
import '../const/app_images.dart';
import '../const/colors.dart';
import '../resource/resource.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorApp.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.88, end: 1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  width: 156,
                  height: 156,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colorApp.surface,
                    borderRadius: BorderRadius.circular(38),
                    boxShadow: [
                      BoxShadow(
                        color: colorApp.button.withValues(alpha: 0.28),
                        blurRadius: 28,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(AppImages.appIcon, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              AppTitle(text: LocaleKeys.app_name.tr(), fontSize: 46),
              const SizedBox(height: 12),
              Text(
                LocaleKeys.splash_tagline.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorApp.score,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: colorApp.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
