// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> _en = {
    "app_name": "2048 Gamer",
    "system_default": "System default",
    "splash_tagline": "Ready to chase your high score",
    "score": "Score",
    "best": "Best",
    "top_score": "Top score",
    "games_played": "Games played",
    "onboarding_title_game": "2048",
    "onboarding_description_game":
        "Merge matching tiles to reach the highest score.",
    "onboarding_title_swipe": "Swipe to play",
    "onboarding_description_swipe":
        "Swipe up, down, left, or right to move the whole board.",
    "onboarding_title_records": "Track your records",
    "onboarding_description_records":
        "Scores from each game are saved with the date and time.",
    "skip": "Skip",
    "start": "Start",
    "continue_button": "Continue",
    "you_win": "You win!",
    "game_over": "Game over!",
    "new_game": "New Game",
    "try_again": "Try again",
    "final_score": "Score: {}",
    "settings": "Settings",
    "background_game": "Game background",
    "board_background": "Board background",
    "tile_colors": "Tile colors",
    "score_history": "Score history",
    "score_history_subtitle": "View and manage saved scores",
    "rate_us": "Rate us",
    "rate_us_subtitle": "Review this app",
    "feedback": "Feedback",
    "feedback_subtitle": "Send feedback by email",
    "feedback_subject": "2048 Gamer Feedback",
    "link_open_error": "Unable to open this link.",
    "clear_score_history_title": "Clear all history?",
    "clear_score_history_message": "All high score history will be deleted.",
    "cancel": "Cancel",
    "clear_all": "Clear all",
    "selected_count": "{} selected",
    "empty_score_history_title": "No score history yet",
    "empty_score_history_message":
        "Scores are saved when you finish or start a new game.",
    "background_mint": "Mint",
    "background_cream": "Cream",
    "background_sky": "Sky",
    "background_rose": "Rose",
    "background_candy": "Candy",
    "background_clouds": "Clouds",
    "background_balloons": "Balloons",
    "tile_theme_sweet": "Sweet",
    "tile_theme_bubblegum": "Bubblegum",
    "tile_theme_rainbow": "Rainbow",
    "onboarding_image_error": "Add artwork here",
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {"en": _en};
}
