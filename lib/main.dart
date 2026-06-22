import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'managers/app_flow.dart';
import 'managers/board.dart';
import 'managers/next_direction.dart';
import 'managers/round.dart';
import 'managers/score_history.dart';
import 'managers/settings.dart';
import 'models/board_adapter.dart';
import 'resource/resource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(BoardAdapter());
  runApp(
    EasyLocalization(
      fallbackLocale: LanguageApp.en,
      path: 'assets/locale',
      supportedLocales: const [Locale("en")],
      useFallbackTranslations: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppFlowManager()),
          ChangeNotifierProvider(create: (_) => ScoreHistoryManager()),
          ChangeNotifierProvider(create: (_) => SettingsManager()),
          ChangeNotifierProvider(create: (_) => RoundManager()),
          ChangeNotifierProvider(create: (_) => NextDirectionManager()),
          ChangeNotifierProvider(
            create: (context) => BoardManager(
              context.read<RoundManager>(),
              context.read<NextDirectionManager>(),
              context.read<ScoreHistoryManager>(),
            ),
          ),
        ],
        child: Builder(
          builder: (context) => MaterialApp(
            title: LocaleKeys.app_name.tr(),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            home: const AppRoot(),
          ),
        ),
      ),
    ),
  );
}
