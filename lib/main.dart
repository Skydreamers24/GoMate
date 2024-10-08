import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gomate/backend/account.dart';
import 'package:gomate/backend/auth_gate.dart';
import 'package:gomate/main_app.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:gomate/backend/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ThemedApp(
    home: I18n(
        child: AuthGate(
            child: Account(
      child: MainApp(),
    ))),
  ));
}
