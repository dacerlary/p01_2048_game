import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/app_images.dart';
import '../const/colors.dart';
import '../managers/app_flow.dart';
import '../resource/resource.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final _pages = const [
    _OnboardingPageData(
      icon: Icons.grid_4x4,
      titleKey: LocaleKeys.onboarding_title_game,
      descriptionKey: LocaleKeys.onboarding_description_game,
      imageUrl: AppImages.onboardingPuzzle,
    ),
    _OnboardingPageData(
      icon: Icons.swipe,
      titleKey: LocaleKeys.onboarding_title_swipe,
      descriptionKey: LocaleKeys.onboarding_description_swipe,
      imageUrl: AppImages.onboardingSwipe,
    ),
    _OnboardingPageData(
      icon: Icons.emoji_events,
      titleKey: LocaleKeys.onboarding_title_records,
      descriptionKey: LocaleKeys.onboarding_description_records,
      imageUrl: AppImages.onboardingTrophy,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() {
    return context.read<AppFlowManager>().finishOnboarding();
  }

  void _next() {
    if (_index == _pages.length - 1) {
      _finish();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorApp.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _finish,
                  child: Text(
                    LocaleKeys.skip.tr(),
                    style: TextStyle(color: colorApp.button),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (value) => setState(() => _index = value),
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return TweenAnimationBuilder<double>(
                      key: ValueKey(page.titleKey),
                      tween: Tween(begin: 0.92, end: 1),
                      duration: const Duration(milliseconds: 420),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(scale: value, child: child);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _OnboardingImage(page: page),
                          const SizedBox(height: 30),
                          Text(
                            page.titleKey.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colorApp.text,
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page.descriptionKey.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colorApp.text,
                              fontSize: 18,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: _index == index ? 28 : 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _index == index
                          ? colorApp.button
                          : colorApp.emptyTile,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorApp.button,
                    foregroundColor: colorApp.textWhite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _index == _pages.length - 1
                        ? LocaleKeys.start.tr()
                        : LocaleKeys.continue_button.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingImage extends StatelessWidget {
  const _OnboardingImage({required this.page});

  final _OnboardingPageData page;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          width: 238,
          height: 206,
          decoration: BoxDecoration(
            color: colorApp.emptyTile,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: colorApp.button.withValues(alpha: 0.18),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            page.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    LocaleKeys.onboarding_image_error.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorApp.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          right: -10,
          bottom: -10,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: -0.08, end: 0.08),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Transform.rotate(angle: value, child: child);
            },
            child: Container(
              width: 74,
              height: 74,
              decoration: BoxDecoration(
                color: colorApp.button,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colorApp.textWhite, width: 4),
              ),
              child: Icon(page.icon, color: colorApp.textWhite, size: 36),
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingPageData {
  const _OnboardingPageData({
    required this.icon,
    required this.titleKey,
    required this.descriptionKey,
    required this.imageUrl,
  });

  final IconData icon;
  final String titleKey;
  final String descriptionKey;
  final String imageUrl;
}
