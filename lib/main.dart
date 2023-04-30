import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rango_mino/core/data.dart';
import 'package:rango_mino/core/theme.dart';
import 'package:rango_mino/firebase_options.dart';
import 'package:rango_mino/src/views/dashboard.dart';
import 'package:rango_mino/src/views/login.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rango&Mino',
      theme: AppTheme.theme,
      home: AppData.account.email == "" ? const LoginView() : DashBoardView(mail: AppData.account.email),
      debugShowCheckedModeBanner: false,
    );
  }
}