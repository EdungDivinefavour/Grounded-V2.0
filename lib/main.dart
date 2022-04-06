import 'package:flutter/material.dart';
import 'package:grounded/grounded.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grounded/models/managers/question_manager.dart';
import 'package:grounded/services/audio/audio_player.dart';
import 'package:grounded/services/local_storage/local_storage.dart';
import 'package:grounded/services/notification/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await NotificationService.instance.init();
  await AudioPlayer.instance.init();
  await LocalStorage.instance.init();
  await QuestionManager.instance.init();

  runApp(Grounded());
}
