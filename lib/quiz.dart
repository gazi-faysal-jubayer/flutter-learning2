import 'package:flutter/material.dart';
import 'package:flutter_learning2/data/questions.dart';
import 'package:flutter_learning2/questions_screen.dart';
import 'package:flutter_learning2/results_screen.dart';
import 'package:flutter_learning2/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  // Widget? activeScreen;

  // @override
  // void initState() {
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }

  // void switchScreen(){
  // setState(() {
  //   activeScreen = const QuestionsScreen();
  // });

  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

void restartQuiz(){
  setState(() {
    selectedAnswers = [];
    activeScreen = 'questions-screen';
  });
}

  @override
  Widget build(context) {
    // final screenWidget = activeScreen == 'start-screen'
    //           ? StartScreen(switchScreen)
    //           : const QuestionsScreen();

    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        choosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
          ),
          // child: activeScreen,
          child: screenWidget,
        ),
      ),
    );
  }
}
