import 'package:safenest/safenest.dart';

void main() async {
  // Initialize client
  final client = SafeNest(apiKey: 'your-api-key');

  try {
    // Quick analysis
    final result = await client.analyze('Message to check');
    print('Risk Level: ${result.riskLevel.value}');
    print('Risk Score: ${result.riskScore}');
    print('Summary: ${result.summary}');

    // Bullying detection
    final bullying = await client.detectBullying(
      'Nobody likes you',
      externalId: 'msg_123',
      metadata: {'user_id': 'user_456'},
    );
    if (bullying.isBullying) {
      print('Bullying detected: ${bullying.severity.value}');
      print('Types: ${bullying.bullyingType.join(', ')}');
    }

    // Grooming detection
    final grooming = await client.detectGrooming(
      DetectGroomingInput(
        messages: [
          const GroomingMessage(
            role: MessageRole.adult,
            content: 'This is our secret',
          ),
          const GroomingMessage(
            role: MessageRole.child,
            content: 'Ok I wont tell',
          ),
        ],
        childAge: 12,
      ),
    );
    print('Grooming risk: ${grooming.groomingRisk.value}');

    // Emotion analysis
    final emotions = await client.analyzeEmotions(
      'I feel so stressed about everything',
    );
    print('Emotions: ${emotions.dominantEmotions.join(', ')}');
    print('Trend: ${emotions.trend.value}');

    // Action plan
    final plan = await client.getActionPlan(
      const GetActionPlanInput(
        situation: 'Someone is spreading rumors about me',
        childAge: 12,
        audience: Audience.child,
        severity: Severity.medium,
      ),
    );
    print('Steps: ${plan.steps.join('\n')}');

    // Usage tracking
    if (client.usage != null) {
      print('API Usage: ${client.usage!.used}/${client.usage!.limit}');
    }
  } on AuthenticationException catch (e) {
    print('Auth error: ${e.message}');
  } on RateLimitException catch (e) {
    print('Rate limited: ${e.message}');
  } on ValidationException catch (e) {
    print('Invalid input: ${e.message}');
  } on SafeNestException catch (e) {
    print('Error: ${e.message}');
  } finally {
    client.close();
  }
}
