/// Severity level for detected issues.
enum Severity {
  low('low'),
  medium('medium'),
  high('high'),
  critical('critical');

  const Severity(this.value);
  final String value;

  static Severity fromString(String value) {
    return Severity.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Severity.low,
    );
  }
}

/// Risk level for grooming detection.
enum GroomingRisk {
  none('none'),
  low('low'),
  medium('medium'),
  high('high'),
  critical('critical');

  const GroomingRisk(this.value);
  final String value;

  static GroomingRisk fromString(String value) {
    return GroomingRisk.values.firstWhere(
      (e) => e.value == value,
      orElse: () => GroomingRisk.none,
    );
  }
}

/// Overall risk level for content analysis.
enum RiskLevel {
  safe('safe'),
  low('low'),
  medium('medium'),
  high('high'),
  critical('critical');

  const RiskLevel(this.value);
  final String value;

  static RiskLevel fromString(String value) {
    return RiskLevel.values.firstWhere(
      (e) => e.value == value,
      orElse: () => RiskLevel.safe,
    );
  }
}

/// Emotion trend direction.
enum EmotionTrend {
  improving('improving'),
  stable('stable'),
  worsening('worsening');

  const EmotionTrend(this.value);
  final String value;

  static EmotionTrend fromString(String value) {
    return EmotionTrend.values.firstWhere(
      (e) => e.value == value,
      orElse: () => EmotionTrend.stable,
    );
  }
}

/// Target audience for action plans.
enum Audience {
  child('child'),
  parent('parent'),
  educator('educator'),
  platform('platform');

  const Audience(this.value);
  final String value;
}

/// Role of message sender in grooming detection.
enum MessageRole {
  adult('adult'),
  child('child'),
  unknown('unknown');

  const MessageRole(this.value);
  final String value;
}
