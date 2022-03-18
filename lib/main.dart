import 'package:flutter/material.dart';
import 'package:grounded/grounded.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grounded/models/managers/question_manager.dart';
import 'package:grounded/services/audio/audio_player.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await AudioPlayer.instance.init();
  await LocalStorage.instance.init();
  await QuestionManager.instance.init();

  runApp(Grounded());
}
