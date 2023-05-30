import 'package:alfred/features/focuslevel/domain/helpers.dart';
import 'package:alfred/features/focuslevel/domain/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:alfred/features/focuslevel/presentation/widgets/focus_levels.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final today = DateTime.now();

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              wakeUpTime: timeOfDayToDate(
                ref.watch(wakeUpTimeProvider),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
