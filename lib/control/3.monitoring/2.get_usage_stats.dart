import 'package:usage_stats/usage_stats.dart';

Future<String?> getCurrentForegroundAppPackageName() async {
  final now = DateTime.now();
  final start = now.subtract(const Duration(seconds: 10));

  try {
    final events = await UsageStats.queryEvents(start, now);

    EventUsageInfo? lastEvent;
    for (var event in events) {
      if (event.eventType == '1') {
        // "1" means MOVE_TO_FOREGROUND
        lastEvent = event;
      }
    }
    return lastEvent?.packageName;
  } catch (e) {
    print("Error getting foreground app: $e");
    return null;
  }
}
