import 'package:audioplayers/audioplayers.dart';
import 'package:grounded/constants/strings/paths.dart';

class AudioTones {
  static const correct = "correct.mp3";
  static const inCorrect = "incorrect.mp3";
  static const swoosh = "swoosh.mp3";
}

class AudioPlayer {
  AudioPlayer._();
  static final AudioPlayer _instance = AudioPlayer._();
  static AudioPlayer get instance => _instance;

  final _audioPlayer = AudioCache(prefix: audioPath);

  Future<void> init() async {
    await _audioPlayer.loadAll([
      AudioTones.correct,
      AudioTones.inCorrect,
      AudioTones.swoosh,
    ]);
  }

  void play(String audio) {
    _audioPlayer.play(audio);
  }
}
