import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/loading_screen.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (details) {
      if (kDebugMode) {
        FlutterError.presentError(details);
      }
    };

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(const MemoryPalaceApp());
  }, (error, stack) {
    if (kDebugMode) {
      debugPrint('Uncaught error: $error');
      debugPrint('Stack: $stack');
    }
  });
}

class MemoryPalaceApp extends StatelessWidget {
  const MemoryPalaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기억의 궁전',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: const LoadingScreen(),
    );
  }
}
