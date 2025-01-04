import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_circle/app.dart';
import 'package:news_circle/core/database/database_helper.dart';
import 'package:news_circle/core/di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await DatabaseHelper().initDatabase();
  await dotenv.load();
  runApp(const App());
}


