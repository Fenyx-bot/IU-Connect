import 'package:chatting/firebase_options.dart';
import 'package:chatting/services/auth/auth_gate.dart';
import 'package:chatting/themes/DarkTheme.dart';
import 'package:chatting/themes/LightTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatting/components/AppStateNotifier.dart';

import 'services/auth/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //themeMode: Provider.of<AppStateNotifier>(context).isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const AuthGate(),
    );
  }
}