// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/background_balloons.png
  AssetGenImage get backgroundBalloons =>
      const AssetGenImage('assets/images/background_balloons.png');

  /// File path: assets/images/background_candy.png
  AssetGenImage get backgroundCandy =>
      const AssetGenImage('assets/images/background_candy.png');

  /// File path: assets/images/background_clouds.png
  AssetGenImage get backgroundClouds =>
      const AssetGenImage('assets/images/background_clouds.png');

  /// File path: assets/images/onboarding_puzzle.png
  AssetGenImage get onboardingPuzzle =>
      const AssetGenImage('assets/images/onboarding_puzzle.png');

  /// File path: assets/images/onboarding_swipe.png
  AssetGenImage get onboardingSwipe =>
      const AssetGenImage('assets/images/onboarding_swipe.png');

  /// File path: assets/images/onboarding_trophy.png
  AssetGenImage get onboardingTrophy =>
      const AssetGenImage('assets/images/onboarding_trophy.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    backgroundBalloons,
    backgroundCandy,
    backgroundClouds,
    onboardingPuzzle,
    onboardingSwipe,
    onboardingTrophy,
  ];
}

class $AssetsLocaleGen {
  const $AssetsLocaleGen();

  /// File path: assets/locale/en.json
  String get en => 'assets/locale/en.json';

  /// File path: assets/locale/scripts.txt
  String get scripts => 'assets/locale/scripts.txt';

  /// List of all assets
  List<String> get values => [en, scripts];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLocaleGen locale = $AssetsLocaleGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
