import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Redirect extends StatefulWidget {
  const Redirect({super.key});

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  void initState() {
    super.initState();

    if (mounted) {
      validator();
    }
  }
  /// Validates if has an wakeuptime setted
  validator() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      context.go("/app/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
