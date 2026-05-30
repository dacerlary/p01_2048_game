import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/app_links.dart';
import '../const/background_options.dart';
import '../const/colors.dart';
import '../const/tile_theme_options.dart';
import '../managers/settings.dart';
import '../resource/resource.dart';
import 'score_history_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _openRateApp(BuildContext context) async {
    await _launch(context, Uri.parse(AppLinks.rateAppUrl));
  }

  Future<void> _openFeedback(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: AppLinks.feedbackEmail,
      queryParameters: {'subject': LocaleKeys.feedback_subject.tr()},
    );
    await _launch(context, uri);
  }

  Future<void> _launch(BuildContext context, Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(LocaleKeys.link_open_error.tr())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsManager>();

    return Scaffold(
      backgroundColor: colorApp.background,
      appBar: AppBar(
        backgroundColor: colorApp.background,
        foregroundColor: colorApp.text,
        elevation: 0,
        title: Text(LocaleKeys.settings.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(
            title: LocaleKeys.board_background.tr(),
            child: settings.isLoading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: CircularProgressIndicator(color: colorApp.button),
                    ),
                  )
                : _BackgroundPicker(
                    selectedId: settings.backgroundId,
                    onSelected: context.read<SettingsManager>().setBackground,
                  ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: LocaleKeys.tile_colors.tr(),
            child: settings.isLoading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: CircularProgressIndicator(color: colorApp.button),
                    ),
                  )
                : _TileThemePicker(
                    selectedId: settings.tileThemeId,
                    onSelected: context.read<SettingsManager>().setTileTheme,
                  ),
          ),
          const SizedBox(height: 16),
          _SettingsTile(
            icon: Icons.history,
            title: LocaleKeys.score_history.tr(),
            subtitle: LocaleKeys.score_history_subtitle.tr(),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ScoreHistoryScreen()),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.star_rate,
            title: LocaleKeys.rate_us.tr(),
            subtitle: LocaleKeys.rate_us_subtitle.tr(),
            onTap: () => _openRateApp(context),
          ),
          _SettingsTile(
            icon: Icons.mail_outline,
            title: LocaleKeys.feedback.tr(),
            subtitle: LocaleKeys.feedback_subtitle.tr(),
            onTap: () => _openFeedback(context),
          ),
        ],
      ),
    );
  }
}

class _TileThemePicker extends StatelessWidget {
  const _TileThemePicker({required this.selectedId, required this.onSelected});

  final String selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: TileThemeOptions.values.map((option) {
        final selected = option.id == selectedId;
        return _TileThemeTile(
          option: option,
          selected: selected,
          onTap: () => onSelected(option.id),
        );
      }).toList(),
    );
  }
}

class _TileThemeTile extends StatelessWidget {
  const _TileThemeTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final TileThemeOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final previewValues = [2, 8, 32, 128];

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorApp.textWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? colorApp.button : colorApp.emptyTile,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: previewValues.map((value) {
                return Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: option.colors[value],
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text(
              option.labelKey.tr(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colorApp.text,
                fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundPicker extends StatelessWidget {
  const _BackgroundPicker({required this.selectedId, required this.onSelected});

  final String selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: GameBackgroundOptions.values.map((option) {
        final selected = option.id == selectedId;
        return _BackgroundOptionTile(
          option: option,
          selected: selected,
          onTap: () => onSelected(option.id),
        );
      }).toList(),
    );
  }
}

class _BackgroundOptionTile extends StatelessWidget {
  const _BackgroundOptionTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final GameBackgroundOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 96,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorApp.textWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? colorApp.button : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: option.color,
                image: option.imageAsset == null
                    ? null
                    : DecorationImage(
                        image: AssetImage(option.imageAsset!),
                        fit: BoxFit.cover,
                      ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: selected
                  ? Icon(
                      Icons.check_circle,
                      color: colorApp.textWhite,
                      shadows: const [
                        Shadow(blurRadius: 8, color: Colors.black45),
                      ],
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            Text(
              option.labelKey.tr(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colorApp.text,
                fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorApp.textWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colorApp.text,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: colorApp.textWhite,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colorApp.score,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: colorApp.textWhite),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: colorApp.text,
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: colorApp.text.withValues(alpha: 0.68),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: colorApp.text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
