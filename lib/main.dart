import 'package:flutter/material.dart';
import 'package:grounded/grounded.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grounded/models/managers/question_manager.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await LocalStorage.instance.init();
  await QuestionManager.instance.init();

  runApp(Grounded());
}
