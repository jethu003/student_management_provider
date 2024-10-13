import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/provider.dart/student_provider.dart';

import 'package:student_management/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Wrap MaterialApp with ChangeNotifierProvider
      create: (context) => StudentProvider(), // Provide StudentProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Students App',
        theme: ThemeData(
          primaryColor: const Color(0xFF141619),
          scaffoldBackgroundColor: const Color(0xFF141619),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
