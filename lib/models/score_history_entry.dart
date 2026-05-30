class ScoreHistoryEntry {
  const ScoreHistoryEntry({
    required this.id,
    required this.score,
    required this.playedAt,
  });

  final String id;
  final int score;
  final DateTime playedAt;

  factory ScoreHistoryEntry.fromMap(Map<dynamic, dynamic> map) {
    return ScoreHistoryEntry(
      id: map['id'] as String,
      score: map['score'] as int,
      playedAt: DateTime.parse(map['playedAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'playedAt': playedAt.toIso8601String(),
    };
  }
}
