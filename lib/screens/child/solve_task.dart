import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar.dart';
import 'package:grounded/components/custom_num_pad.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/question/question.dart';
import 'package:grounded/services/audio/audio_player.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SolveTask extends StatefulWidget {
  final GroundedTask task;
  SolveTask({required this.task});

  @override
  State<SolveTask> createState() => _SolveTaskState();
}

class _SolveTaskState extends State<SolveTask> {
  String? _displayedQuestionText;
  String? _pickedAnswer;

  Timer? _timer;

  int _currentQuestionIndex = 0;
  int _timeSpentOnQuestion = 0;
  int _numberOfTimesAttempted = 0;

  @override
  void initState() {
    super.initState();

    _setCurrentQuestionIndex();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),
      bubblePosition: BackgroundBubblePosition.centerRight,
      body: SizedBox(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: _buildColumn,
            )),
      ),
    );
  }

  List<Widget> get _buildColumn {
    final List<Widget> solveTaskWidgets = [
      Row(
        children: [
          Spacer(),
          PNGIcon(icon: AppIcons.clockPNG, size: 25),
          SizedBox(width: 5),
          Text(_buildDisplayedTime,
              style: TextStyles.chalkboard.copyWith(fontSize: 22).copyWith(
                  color: _timeSpentOnQuestion < 60
                      ? ThemeColors.primary
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
              style: TextStyles.chalkboard.copyWith(fontSize: 22)),
        ],
      ),
      SizedBox(height: 15),
      LinearPercentIndicator(
        barRadius: Radius.circular(5),
        lineHeight: 8.0,
        percent: widget.task.completedPercentage / 100,
        progressColor: ThemeColors.link,
        backgroundColor: ThemeColors.primaryLight,
      ),
      SizedBox(height: 40),
    ];

    widget.task.subjectType == SubjectType.english
        ? solveTaskWidgets.addAll(_buildEnglishQuestionBody)
        : solveTaskWidgets.addAll(_buildMathsQuestionBody);

    return solveTaskWidgets;
  }

  List<Widget> get _buildEnglishQuestionBody {
    return [
      Text('What letter is missing?',
          style: TextStyles.chalkboard.copyWith(fontSize: 26)),
      SizedBox(height: 40),
      PNGIcon(
        size: 160,
        icon: 'questions/${_currentQuestion.word!.toLowerCase()}.png',
        pngSource: PNGSource.images,
      ),
      SizedBox(height: 50),
      _displayedQuestionText == null
          ? emptyWidget
          : Text(_displayedQuestionText!,
              style: TextStyles.chalkboard.copyWith(
                  fontSize: _displayedQuestionText!.length < 8 ? 62 : 37)),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _currentQuestion.suggestedAnswers!
            .map((x) => _buildEnglishSuggestedAnswerBox(x))
            .toList(),
      ),
      Spacer(),
      CustomActionButton(
          title: 'Proceed', hasChalkBoardFont: true, onPressed: _confirmAnswer),
      SizedBox(height: 40),
    ];
  }

  Widget _buildEnglishSuggestedAnswerBox(String buttonText) {
    return InkWell(
      onTap: () {
        _appendToAnswer(buttonText);
      },
      child: Container(
        margin: EdgeInsets.all(7.5),
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColors.primaryDark),
          borderRadius: BorderRadius.circular(15),
          color: ThemeColors.lightBackground,
        ),
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: Text(buttonText,
            style: TextStyles.chalkboard
                .copyWith(fontSize: 26, color: ThemeColors.darkElement)),
      ),
    );
  }

  List<Widget> get _buildMathsQuestionBody {
    return [
      Text('Answer this question',
          style: TextStyles.chalkboard.copyWith(fontSize: 24)),
      _displayedQuestionText == null
          ? emptyWidget
          : Text(_displayedQuestionText!,
              style: TextStyles.smallBold.copyWith(
                  fontSize: _displayedQuestionText!.length < 8 ? 80 : 60)),
      Spacer(),
      _pickedAnswer == null
          ? emptyWidget
          : Container(
              padding: EdgeInsets.only(right: 30),
              alignment: Alignment.centerRight,
              child: Text(
                _pickedAnswer!,
                style: TextStyles.chalkboard.copyWith(fontSize: 50),
              )),
      Spacer(),
      CustomNumPad(
        onKeyPressed: _appendToAnswer,
        onEnter: _confirmAnswer,
        onDelete: _deleteFromAnswer,
      )
    ];
  }

  Question get _currentQuestion {
    return widget.task.questions[_currentQuestionIndex];
  }

  String get _buildDisplayedTime {
    final timeSpentOnQuestionMinutePart = _timeSpentOnQuestion ~/ 60;
    final timeSpentOnQuestionSecondPart =
        _timeSpentOnQuestion - (timeSpentOnQuestionMinutePart * 60);

    bool shouldAttachZeroAsPrefixToLeftSide = false;
    bool shouldAttachZeroAsPrefixToRightSide = false;

    if (_timeSpentOnQuestion % 60 < 10) {
      shouldAttachZeroAsPrefixToRightSide = true;
    }

    if (_timeSpentOnQuestion < 600) {
      shouldAttachZeroAsPrefixToLeftSide = true;
    }

    return '${shouldAttachZeroAsPrefixToLeftSide ? '0' : ''}$timeSpentOnQuestionMinutePart:${shouldAttachZeroAsPrefixToRightSide ? '0' : ''}$timeSpentOnQuestionSecondPart';
  }

  void _appendToAnswer(String value) {
    if (_pickedAnswer == null) {
      _pickedAnswer = value;
    } else {
      _pickedAnswer = _pickedAnswer! + value;
    }

    setState(() {
      if (widget.task.subjectType == SubjectType.english) {
        _displayedQuestionText = _currentQuestion.displayedQuestion
            ?.replaceFirst('_', _pickedAnswer!);
      }
    });
  }

  void _confirmAnswer() async {
    final wasAnswerCorrect = _pickedAnswer == _currentQuestion.correctAnswer;
    if (_pickedAnswer == null) {
      EasyLoading.showError("Please enter an answer to proceed");
      return;
    }

    _numberOfTimesAttempted++;
    AudioPlayer.instance
        .play(wasAnswerCorrect ? AudioTones.correct : AudioTones.inCorrect);
    if (!wasAnswerCorrect) {
      setState(() {
        _currentQuestion.pickedAnswer = _pickedAnswer = null;
      });

      if (widget.task.subjectType == SubjectType.english) {
        setState(() {
          _displayedQuestionText = _currentQuestion.displayedQuestion;
        });
      }
      return;
    }

    _currentQuestion.pickedAnswer = _pickedAnswer;
    _currentQuestion.timeSpentOnQuestion = _timeSpentOnQuestion;
    _currentQuestion.numberOfTimesAttempted = _numberOfTimesAttempted;
    _currentQuestion.setHasBeenAnswered();

    if (widget.task.hasBeenCompleted) {
      AudioPlayer.instance.play(AudioTones.congrats);

      await _showCongratulationsDialog();
      Navigator.pop(context);

      return;
    }

    _resetScreenVariables();
  }

  void _deleteFromAnswer() {
    if (_pickedAnswer == null) {
      EasyLoading.showError("Unable to delete as no input has been entered");
      return;
    }

    final lastIndex = _pickedAnswer!.length;
    setState(() {
      _pickedAnswer = _pickedAnswer!.substring(0, lastIndex - 1);
    });
  }

  void _setCurrentQuestionIndex() {
    if (widget.task.lastCompletedQuestion == null) {
      _currentQuestionIndex = 0;
    } else {
      _currentQuestionIndex =
          widget.task.questions.indexOf(widget.task.lastCompletedQuestion!) + 1;
    }

    _displayedQuestionText = _currentQuestion.displayedQuestion;
    _pickedAnswer = _currentQuestion.pickedAnswer;
    _numberOfTimesAttempted = _currentQuestion.numberOfTimesAttempted;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() => _timeSpentOnQuestion++);
      _currentQuestion.timeSpentOnQuestion = _timeSpentOnQuestion;
    });
  }

  void _resetScreenVariables() {
    setState(() {
      _currentQuestionIndex++;
      _displayedQuestionText = _currentQuestion.displayedQuestion;
      _pickedAnswer = null;
      _timeSpentOnQuestion = 0;
    });
  }

  Future<void> _showCongratulationsDialog() async {
    final dialog = Dialog(
        child: SizedBox(
      height: 350,
      width: 600,
      child: Column(
        children: const [
          PNGIcon(icon: AppIcons.celebratePNG, size: 270),
          Text("Congratulations xxx!", style: TextStyles.bold),
          SizedBox(height: 10),
          Text("You did an amazing job!", style: TextStyles.regular)
        ],
      ),
    ));

    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(alignment: Alignment.bottomCenter, child: dialog);
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );

    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
  }
}
