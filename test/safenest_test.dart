import 'package:flutter_test/flutter_test.dart';
import 'package:safenest/safenest.dart';

void main() {
  group('Client Initialization', () {
    test('creates client with valid API key', () {
      final client = SafeNest(apiKey: 'test-api-key-12345');
      expect(client, isNotNull);
      client.close();
    });

    test('throws on empty API key', () {
      expect(
        () => SafeNest(apiKey: ''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws on short API key', () {
      expect(
        () => SafeNest(apiKey: 'short'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('accepts custom options', () {
      final client = SafeNest(
        apiKey: 'test-api-key-12345',
        timeout: const Duration(seconds: 60),
        maxRetries: 5,
        retryDelay: const Duration(seconds: 2),
      );
      expect(client, isNotNull);
      client.close();
    });
  });

  group('Enum Values', () {
    test('Severity enum has correct values', () {
      expect(Severity.low.value, 'low');
      expect(Severity.medium.value, 'medium');
      expect(Severity.high.value, 'high');
      expect(Severity.critical.value, 'critical');
    });

    test('Severity.fromString works', () {
      expect(Severity.fromString('low'), Severity.low);
      expect(Severity.fromString('critical'), Severity.critical);
      expect(Severity.fromString('unknown'), Severity.low);
    });

    test('GroomingRisk enum has correct values', () {
      expect(GroomingRisk.none.value, 'none');
      expect(GroomingRisk.low.value, 'low');
      expect(GroomingRisk.high.value, 'high');
      expect(GroomingRisk.critical.value, 'critical');
    });

    test('RiskLevel enum has correct values', () {
      expect(RiskLevel.safe.value, 'safe');
      expect(RiskLevel.low.value, 'low');
      expect(RiskLevel.medium.value, 'medium');
      expect(RiskLevel.high.value, 'high');
      expect(RiskLevel.critical.value, 'critical');
    });

    test('EmotionTrend enum has correct values', () {
      expect(EmotionTrend.improving.value, 'improving');
      expect(EmotionTrend.stable.value, 'stable');
      expect(EmotionTrend.worsening.value, 'worsening');
    });

    test('Audience enum has correct values', () {
      expect(Audience.child.value, 'child');
      expect(Audience.parent.value, 'parent');
      expect(Audience.educator.value, 'educator');
      expect(Audience.platform.value, 'platform');
    });

    test('MessageRole enum has correct values', () {
      expect(MessageRole.adult.value, 'adult');
      expect(MessageRole.child.value, 'child');
      expect(MessageRole.unknown.value, 'unknown');
    });
  });

  group('Model Creation', () {
    test('AnalysisContext creation works', () {
      const context = AnalysisContext(
        language: 'en',
        ageGroup: '11-13',
        relationship: 'classmates',
        platform: 'chat',
      );
      expect(context.language, 'en');
      expect(context.ageGroup, '11-13');
    });

    test('AnalysisContext.toJson excludes null values', () {
      const context = AnalysisContext(language: 'en');
      final json = context.toJson();
      expect(json, {'language': 'en'});
      expect(json.containsKey('age_group'), false);
    });

    test('GroomingMessage creation works', () {
      const msg = GroomingMessage(
        role: MessageRole.adult,
        content: 'Hello',
      );
      expect(msg.role, MessageRole.adult);
      expect(msg.content, 'Hello');
    });

    test('DetectGroomingInput creation works', () {
      const input = DetectGroomingInput(
        messages: [
          GroomingMessage(role: MessageRole.adult, content: 'Hello'),
          GroomingMessage(role: MessageRole.child, content: 'Hi'),
        ],
        childAge: 12,
      );
      expect(input.messages.length, 2);
      expect(input.childAge, 12);
    });

    test('EmotionMessage creation works', () {
      const msg = EmotionMessage(sender: 'user', content: 'I feel happy');
      expect(msg.sender, 'user');
      expect(msg.content, 'I feel happy');
    });

    test('GetActionPlanInput creation works', () {
      const input = GetActionPlanInput(
        situation: 'Someone is spreading rumors',
        childAge: 12,
        audience: Audience.child,
        severity: Severity.medium,
      );
      expect(input.situation, 'Someone is spreading rumors');
      expect(input.childAge, 12);
      expect(input.audience, Audience.child);
      expect(input.severity, Severity.medium);
    });

    test('ReportMessage creation works', () {
      const msg = ReportMessage(sender: 'user1', content: 'Bad message');
      expect(msg.sender, 'user1');
      expect(msg.content, 'Bad message');
    });

    test('GenerateReportInput creation works', () {
      const input = GenerateReportInput(
        messages: [
          ReportMessage(sender: 'user1', content: 'Bad'),
          ReportMessage(sender: 'child', content: 'Stop'),
        ],
        childAge: 14,
        incidentType: 'bullying',
      );
      expect(input.messages.length, 2);
      expect(input.childAge, 14);
      expect(input.incidentType, 'bullying');
    });
  });

  group('Error Classes', () {
    test('SafeNestException has message', () {
      const error = SafeNestException('Test error');
      expect(error.message, 'Test error');
      expect(error.toString(), 'SafeNestException: Test error');
    });

    test('AuthenticationException works', () {
      const error = AuthenticationException('Invalid key');
      expect(error.message, 'Invalid key');
      expect(error.toString(), 'AuthenticationException: Invalid key');
    });

    test('ServerException has status code', () {
      const error = ServerException('Server error', 500);
      expect(error.message, 'Server error');
      expect(error.statusCode, 500);
      expect(error.toString(), 'ServerException (500): Server error');
    });
  });
}
