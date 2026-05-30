import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/button.dart';
import 'components/app_title.dart';
import 'components/empy_board.dart';
import 'components/score_board.dart';
import 'components/tile_board.dart';
import 'const/colors.dart';
import 'managers/board.dart';
import 'models/game_direction.dart';
import 'resource/resource.dart';
import 'screens/settings_screen.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final FocusNode _keyboardFocusNode = FocusNode();
  Offset _dragDelta = Offset.zero;

  late final AnimationController _moveController =
      AnimationController(
        duration: const Duration(milliseconds: 100),
        vsync: this,
      )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          context.read<BoardManager>().merge();
          _scaleController.forward(from: 0.0);
        }
      });

  late final CurvedAnimation _moveAnimation = CurvedAnimation(
    parent: _moveController,
    curve: Curves.easeInOut,
  );

  late final AnimationController _scaleController =
      AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (context.read<BoardManager>().endRound()) {
            _moveController.forward(from: 0.0);
          }
        }
      });

  late final CurvedAnimation _scaleAnimation = CurvedAnimation(
    parent: _scaleController,
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      autofocus: true,
      focusNode: _keyboardFocusNode,
      onKeyEvent: (KeyEvent event) {
        if (context.read<BoardManager>().onKey(event)) {
          _moveController.forward(from: 0.0);
        }
      },
      child: Scaffold(
        backgroundColor: colorApp.background,
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 360),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: colorApp.background,
            gradient: LinearGradient(
              colors: [colorApp.background, colorApp.emptyTile],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorApp.surface.withValues(alpha: 0.86),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: colorApp.button.withValues(alpha: 0.14),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTitle(text: LocaleKeys.app_name.tr()),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                ButtonWidget(
                                  icon: Icons.refresh,
                                  onPressed: () {
                                    context.read<BoardManager>().newGame();
                                  },
                                ),
                                ButtonWidget(
                                  icon: Icons.settings,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const SettingsScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: ScoreBoard(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: (_) => _dragDelta = Offset.zero,
                  onPanUpdate: (details) => _dragDelta += details.delta,
                  onPanEnd: (_) {
                    final direction = _swipeDirectionFromDelta(_dragDelta);
                    if (direction != null &&
                        context.read<BoardManager>().move(direction)) {
                      _moveController.forward(from: 0.0);
                    }
                  },
                  child: Stack(
                    children: [
                      const EmptyBoardWidget(),
                      TileBoardWidget(
                        moveAnimation: _moveAnimation,
                        scaleAnimation: _scaleAnimation,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      context.read<BoardManager>().save();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _moveAnimation.dispose();
    _scaleAnimation.dispose();
    _moveController.dispose();
    _scaleController.dispose();
    _keyboardFocusNode.dispose();
    super.dispose();
  }

  GameDirection? _swipeDirectionFromDelta(Offset delta) {
    const minSwipeDistance = 24.0;
    if (delta.distance < minSwipeDistance) {
      return null;
    }

    if (delta.dx.abs() > delta.dy.abs()) {
      return delta.dx > 0 ? GameDirection.right : GameDirection.left;
    }
    return delta.dy > 0 ? GameDirection.down : GameDirection.up;
  }
}
