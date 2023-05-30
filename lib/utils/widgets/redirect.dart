import 'package:alfred/features/focuslevel/domain/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Redirect extends ConsumerStatefulWidget {
  const Redirect({super.key});

  @override
  createState() => _RedirectState();
}

class _RedirectState extends ConsumerState<Redirect> {
  bool hasWakeUpTime = true;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      validator();
    }
  }

  /// Validates if has an wakeuptime setted
  validator() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final today = DateTime.now();
    final formattedDate = "${today.day}-${today.month}-${today.year}";

    final wus = prefs.getString(formattedDate);

    if (wus != null) {
      if (mounted) {
        final wakeUpTime = ref.read(wakeUpTimeProvider.notifier);
        wakeUpTime.state = TimeOfDay(
          hour: int.parse(wus.split(":")[0]),
          minute: int.parse(wus.split(":")[1])
        );
        
        context.go("/app/home");
      }
      return;
    }

    setState(() {
      hasWakeUpTime = false;
    });

    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasWakeUpTime
          ? _showLoader()
          : Center(
              child: FilledButton.tonal(
                onPressed: () => _selectTime(context),
                child: const Text("Select a wake up time"),
              ),
            ),
    );
  }

  _selectTime(BuildContext context) {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      initialTime: const TimeOfDay(hour: 6, minute: 30),
      context: context,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    selectedTime.then((value) async {
      if (value != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final today = DateTime.now();
        final formattedDate = "${today.day}-${today.month}-${today.year}";

        if (mounted) {
          prefs.setString(formattedDate, value.format(context));
          final wakeUpTime = ref.read(wakeUpTimeProvider.notifier);
          print(value.format(context));
          wakeUpTime.state = value;
          context.go("/app/home");
        }
      }
    });
  }
}

_showLoader() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
