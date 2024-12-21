import 'package:flutter/material.dart';
import '../services/fitness_service.dart';

class FitnessTrackerPage extends StatefulWidget {
  @override
  _FitnessTrackerPageState createState() => _FitnessTrackerPageState();
}

class _FitnessTrackerPageState extends State<FitnessTrackerPage> {
  final FitnessService _fitnessService = FitnessService();
  int? _steps;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchStepCount();
  }

  Future<void> _fetchStepCount() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final steps = await _fitnessService.fetchStepCount();
      setState(() {
        _steps = steps;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _error != null
                ? Text(
                    'Error: $_error',
                    style: const TextStyle(color: Colors.red),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _steps != null
                            ? "You've walked $_steps steps today. Great job!"
                            : "No step data available.",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _fetchStepCount,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh'),
                      ),
                    ],
                  ),
      ),
    );
  }
}
