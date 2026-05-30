import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../managers/score_history.dart';
import '../models/score_history_entry.dart';
import '../resource/resource.dart';

class ScoreHistoryScreen extends StatefulWidget {
  const ScoreHistoryScreen({super.key});

  @override
  State<ScoreHistoryScreen> createState() => _ScoreHistoryScreenState();
}

class _ScoreHistoryScreenState extends State<ScoreHistoryScreen> {
  final Set<String> _selectedIds = {};

  bool get _isSelecting => _selectedIds.isNotEmpty;

  void _toggle(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  Future<void> _deleteSelected() async {
    await context.read<ScoreHistoryManager>().deleteMany(_selectedIds);
    setState(_selectedIds.clear);
  }

  Future<void> _clearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LocaleKeys.clear_score_history_title.tr()),
        content: Text(LocaleKeys.clear_score_history_message.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(LocaleKeys.cancel.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(LocaleKeys.clear_all.tr()),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!mounted) return;

    await context.read<ScoreHistoryManager>().clearAll();
    setState(_selectedIds.clear);
  }

  @override
  Widget build(BuildContext context) {
    final manager = context.watch<ScoreHistoryManager>();
    final entries = manager.entries;

    return Scaffold(
      backgroundColor: colorApp.background,
      appBar: AppBar(
        backgroundColor: colorApp.background,
        foregroundColor: colorApp.text,
        elevation: 0,
        title: Text(
          _isSelecting
              ? LocaleKeys.selected_count.tr(args: ['${_selectedIds.length}'])
              : LocaleKeys.score_history.tr(),
        ),
        actions: [
          if (_isSelecting)
            IconButton(
              onPressed: _deleteSelected,
              icon: const Icon(Icons.delete_outline),
            ),
          if (entries.isNotEmpty)
            IconButton(
              onPressed: _clearAll,
              icon: const Icon(Icons.delete_sweep_outlined),
            ),
        ],
      ),
      body: manager.isLoading
          ? Center(child: CircularProgressIndicator(color: colorApp.button))
          : entries.isEmpty
          ? _EmptyHistory()
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _TopScoreHeader(entries: entries),
                const SizedBox(height: 16),
                ...List.generate(entries.length, (index) {
                  final entry = entries[index];
                  final selected = _selectedIds.contains(entry.id);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _HistoryTile(
                      entry: entry,
                      rank: index + 1,
                      selected: selected,
                      selecting: _isSelecting,
                      onTap: () {
                        if (_isSelecting) {
                          _toggle(entry.id);
                        }
                      },
                      onLongPress: () => _toggle(entry.id),
                    ),
                  );
                }),
              ],
            ),
    );
  }
}

class _TopScoreHeader extends StatelessWidget {
  const _TopScoreHeader({required this.entries});

  final List<ScoreHistoryEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorApp.button, colorApp.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: colorApp.button.withValues(alpha: 0.2),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.emoji_events, color: colorApp.textWhite, size: 46),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.top_score.tr(),
                  style: TextStyle(
                    color: colorApp.textWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${entries.first.score}',
                  style: TextStyle(
                    color: colorApp.textWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                LocaleKeys.games_played.tr(),
                style: TextStyle(
                  color: colorApp.textWhite.withValues(alpha: 0.86),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${entries.length}',
                style: TextStyle(
                  color: colorApp.textWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.entry,
    required this.rank,
    required this.selected,
    required this.selecting,
    required this.onTap,
    required this.onLongPress,
  });

  final ScoreHistoryEntry entry;
  final int rank;
  final bool selected;
  final bool selecting;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? colorApp.emptyTile : colorApp.textWhite,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        onLongPress: onLongPress,
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
                child: Center(
                  child: Text(
                    '#$rank',
                    style: TextStyle(
                      color: colorApp.textWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${entry.score}',
                      style: TextStyle(
                        color: colorApp.text,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDateTime(entry.playedAt),
                      style: TextStyle(
                        color: colorApp.text.withValues(alpha: 0.68),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (selecting)
                Icon(
                  selected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: selected ? colorApp.button : colorApp.text,
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$hour:$minute $day/$month/${value.year}';
  }
}

class _EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emoji_events_outlined, color: colorApp.button, size: 64),
            const SizedBox(height: 16),
            Text(
              LocaleKeys.empty_score_history_title.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorApp.text,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.empty_score_history_message.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorApp.text.withValues(alpha: 0.72),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
