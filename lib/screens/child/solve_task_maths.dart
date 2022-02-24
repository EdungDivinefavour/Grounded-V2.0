import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_num_pad.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/empty_widget.dart';
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

class SolveTaskMaths extends StatefulWidget {
  final GroundedTask task;
  SolveTaskMaths({required this.task});

  @override
  State<SolveTaskMaths> createState() => _SolveTaskMathsState();
}

class _SolveTaskMathsState extends State<SolveTaskMaths> {
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
        bubblePosition: BackgroundBubblePosition.centerRight,
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
                SizedBox(height: 40),
                Text('Answer this question',
                    style: TextStyles.bold.copyWith(fontSize: 18)),
                Text(_currentQuestion.displayedQuestion!,
                    style: TextStyles.smallBold.copyWith(
                        fontSize: _currentQuestion.displayedQuestion!.length < 8
                            ? 80
                            : 60)),
                Spacer(),
                _currentQuestion.pickedAnswer == null
                    ? emptyWidget
                    : Container(
                        padding: EdgeInsets.only(right: 30),
                        alignment: Alignment.centerRight,
                        child: Text(
                          _currentQuestion.pickedAnswer!,
                          style: TextStyles.semiBold.copyWith(fontSize: 40),
                        )),
                Spacer(),
                CustomNumPad(
                  onKeyPressed: _appendToAnswer,
                  onEnter: _confirmAnswer,
                  onDelete: _deleteFromAnswer,
                )
              ])),
        ));
  }

  Question _getCurrentQuestion() {
    return widget.task.questions[_currentQuestionIndex];
  }

  void _appendToAnswer(String value) {
    if (_pickedAnswer == null) {
      _pickedAnswer = value;
      setState(() {
        _currentQuestion.pickedAnswer = _pickedAnswer;
      });
    } else {
      _pickedAnswer = _pickedAnswer! + value;
      setState(() {
        _currentQuestion.pickedAnswer = _pickedAnswer;
      });
    }
  }

  void _confirmAnswer() {
    // if no answer was picked
    if (_pickedAnswer == null) {
      EasyLoading.showError("Please enter an answer to proceed");
      return;
    }

    // Play audio after answer is selected
    if (_pickedAnswer == _currentQuestion.correctAnswer) {
      _audioPlayer.play(correctTone);
    } else {
      _audioPlayer.play(inCorrectTone);
    }

    _currentQuestion.setHasBeenAnswered();
    if (widget.task.hasBeenCompleted) {
      // ShowPOPUP congratulating them
      Navigator.pop(context);
      return;
    }

    setState(() {
      _currentQuestionIndex++;
      _pickedAnswer = null;
      _remainingTimeForQuestion = 10;
    });
  }

  void _deleteFromAnswer() {
    if (_pickedAnswer == null) {
      EasyLoading.showError("Unable to delete as no input has been entered");
      return;
    }

    final lastIndex = _pickedAnswer!.length;
    _pickedAnswer = _pickedAnswer!.substring(0, lastIndex - 1);

    setState(() {
      _currentQuestion.pickedAnswer = _pickedAnswer;
    });
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
        _remainingTimeForQuestion = 10;
      }
    });
  }

  void _initializeAudioPlayer() {
    _audioPlayer.loadAll([correctTone, inCorrectTone]);
  }
}
