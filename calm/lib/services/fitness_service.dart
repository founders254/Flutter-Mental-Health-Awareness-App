import 'package:health/health.dart';

class FitnessService {
  final HealthFactory _health = HealthFactory();

  Future<int> fetchStepCount() async {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));
    final types = [HealthDataType.STEPS];

    // Request permissions
    bool granted = await _health.requestAuthorization(types);
    if (!granted) {
      throw Exception("Permission not granted");
    }

    // Fetch step count
    try {
      final data = await _health.getHealthDataFromTypes(yesterday, now, types);
      final steps = data.fold<int>(
        0,
        (sum, item) => sum + (item.value as int),
      );
      return steps;
    } catch (e) {
      throw Exception("Failed to fetch step count: $e");
    }
  }
}
