import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    if (mounted) {
      validator();
    }
  }

  validator() async {
    await Future.delayed(const Duration(seconds: 3));
    //TODO validate user
    if (mounted) {
      context.go("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(
          radius: 12,
        ),
      ),
    );
  }
}
