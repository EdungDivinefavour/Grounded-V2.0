import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/constants/strings/paths.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/question/question.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

const correctTone = "correct.mp3";
const inCorrectTone = "incorrect.mp3";

class SolveTaskEnglish extends StatefulWidget {
  final GroundedTask task;
  SolveTaskEnglish({required this.task});

  @override
  State<SolveTaskEnglish> createState() => _SolveTaskEnglishState();
}

class _SolveTaskEnglishState extends State<SolveTaskEnglish> {
  final _audioPlayer = AudioCache(prefix: audioPath);

  int _currentQuestionIndex = 0;
  int _remainingTimeForQuestion = 10;

  String? _pickedAnswer;

  Question get _currentQuestion => _getCurrentQuestion();

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _initializeAudioPlayer();
    _setCurrentQuestionIndex();
    _startCountDownTimer();
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
    _audioPlayer.clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),
      bubblePosition: BackgroundBubblePosition.topRight,
      body: SizedBox(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Row(
                children: [
                  Spacer(),
                  SVGIcon(
                      icon: AppIcons.clock,
                      size: 25,
                      color: _remainingTimeForQuestion > 5
                          ? ThemeColors.darkBackground
                          : ThemeColors.error),
                  SizedBox(width: 5),
                  Text(
                      '0:${_remainingTimeForQuestion == 10 ? "" : 0}$_remainingTimeForQuestion',
                      style: TextStyles.smallBold
                          .copyWith(fontSize: 18)
                          .copyWith(
                              color: _remainingTimeForQuestion > 5
                                  ? ThemeColors.darkBackground
                                  : ThemeColors.error)),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 5),
                  Text(widget.task.completedQuestionsRatio,
                      style: TextStyles.smallBold.copyWith(fontSize: 20)),
                  Spacer(),
                  SVGIcon(icon: AppIcons.star, size: 25),
                  SizedBox(width: 6),
                  Text('${widget.task.totalPointsGotten} points',
                      style: TextStyles.smallBold.copyWith(fontSize: 20)),
                ],
              ),
              SizedBox(height: 15),
              LinearPercentIndicator(
                barRadius: Radius.circular(5),
                lineHeight: 8.0,
                percent: widget.task.completedPercentage / 100,
                progressColor: ThemeColors.primary,
                backgroundColor: ThemeColors.primaryLight,
              ),
              SizedBox(height: 50),
              Text('What letter is missing?',
                  style: TextStyles.bold.copyWith(fontSize: 18)),
              SizedBox(height: 40),
              PNGIcon(
                size: 160,
                icon:
                    'questions/${_currentQuestion.word!.text.toLowerCase()}.png',
                pngSource: PNGSource.images,
              ),
              SizedBox(height: 50),
              Text(_currentQuestion.displayedQuestion!,
                  style: TextStyles.medium.copyWith(
                      fontSize: _currentQuestion.displayedQuestion!.length < 8
                          ? 60
                          : 35)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _currentQuestion.suggestedAnswers!
                    .map((x) => _buildSuggestedAnswerBox(x))
                    .toList(),
              ),
              Spacer(),
              CustomActionButton(title: 'Proceed', onPressed: _confirmAnswer),
              SizedBox(height: 40),
            ])),
      ),
    );
  }

  Widget _buildSuggestedAnswerBox(String buttonText) {
    return InkWell(
      onTap: () {
        _appendToAnswer(buttonText);
      },
      child: Container(
        margin: EdgeInsets.all(7.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ThemeColors.lightBackground,
        ),
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: Text(buttonText,
            style: TextStyles.semiBold
                .copyWith(fontSize: 22, color: ThemeColors.darkElement)),
      ),
    );
  }

  Question _getCurrentQuestion() {
    return widget.task.questions[_currentQuestionIndex];
  }

  void _appendToAnswer(String value) {
    if (_pickedAnswer == null) {
      _pickedAnswer = value;
    } else {
      _pickedAnswer = _pickedAnswer! + value;
    }

    setState(() {
      _currentQuestion.pickedAnswer = _pickedAnswer;
      _currentQuestion.displayedQuestion =
          _currentQuestion.displayedQuestion?.replaceFirst('_', _pickedAnswer!);
    });
  }

  void _confirmAnswer() {
    if (_pickedAnswer == null) {
      EasyLoading.showError("Please enter an answer to proceed");
      return;
    }

    _currentQuestion.setHasBeenAnswered();
    _audioPlayer.play(_pickedAnswer == _currentQuestion.correctAnswer
        ? correctTone
        : inCorrectTone);

    if (widget.task.hasBeenCompleted) {
      Navigator.pop(context);
      return;
    }

    _resetScreenVariables();
  }

  void _setCurrentQuestionIndex() {
    if (widget.task.lastCompletedQuestion == null) {
      _currentQuestionIndex = 0;
      return;
    }

    _currentQuestionIndex =
        widget.task.questions.indexOf(widget.task.lastCompletedQuestion!) + 1;
  }

  void _startCountDownTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() => _remainingTimeForQuestion--);

      if (_remainingTimeForQuestion == 0) {
        _appendToAnswer("");
        _confirmAnswer();
      }
    });
  }

  void _initializeAudioPlayer() {
    _audioPlayer.loadAll([correctTone, inCorrectTone]);
  }

  void _resetScreenVariables() {
    setState(() {
      _currentQuestionIndex++;
      _pickedAnswer = null;
      _remainingTimeForQuestion = 10;
    });
  }
}
