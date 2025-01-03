import 'package:flutter/material.dart';
import 'package:news_circle/app.dart';
import 'package:news_circle/core/di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const App());
}


