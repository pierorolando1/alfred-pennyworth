import 'package:alfred/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AlfredApp());
}

class AlfredApp extends StatelessWidget {
  const AlfredApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Alfred Pennnyworth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 80, 133, 164), brightness: Brightness.dark),
        useMaterial3: true,
      ),
      
      routerConfig: mainRouter, 
    );
  }
}