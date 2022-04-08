import 'package:audioplayers/audioplayers.dart';
import 'package:grounded/constants/strings/paths.dart';

class AudioTones {
  static const correct = "correct.mp3";
  static const congrats = "congrats.mp3";
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
      AudioTones.congrats,
      AudioTones.inCorrect,
      AudioTones.swoosh,
    ]);
  }

  Future<void> play(String audio) {
    return _audioPlayer.play(audio);
  }
}
