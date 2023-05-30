import 'package:flutter/material.dart';
import 'package:alfred/features/focuslevel/presentation/widgets/focus_levels.dart';

final today = DateTime.now();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Text(
              "Welcome young Piero",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            FocusLevels(
              //today at 7:20 am
              wakeUpTime: DateTime(today.year, today.month, today.day, 6, 10),
            ),
          ],
        ),
      ),
    );
  }
}
