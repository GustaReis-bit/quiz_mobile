import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../models/question.dart';
import '../widgets/question_card.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String playerName;

  const QuizScreen({
    super.key,
    required this.playerName,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  late List<Question> quizQuestions;

  int currentQuestion = 0;
  int score = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  String? selectedAnswer;

  Timer? timer;
  int timeLeft = 30;

  @override
  void initState() {
    super.initState();

    generateQuiz();
    startTimer();
  }

  void generateQuiz() {
    final random = Random();

    List<Question> shuffled = List.from(allQuestions);

    shuffled.shuffle(random);

    quizQuestions = shuffled.take(10).map((q) {

      List<String> options = List.from(q.options);
      options.shuffle(random);

      return Question(
        question: q.question,
        options: options,
        answer: q.answer,
      );

    }).toList();
  }

  void startTimer() {

    timer?.cancel();

    timeLeft = 30;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {

        if (timeLeft == 0) {
          nextQuestion();
        } else {
          setState(() {
            timeLeft--;
          });
        }
      },
    );
  }

  void nextQuestion() {

    if (selectedAnswer != null) {

      if (selectedAnswer ==
          quizQuestions[currentQuestion].answer) {

        score++;
        correctAnswers++;
      } else {
        wrongAnswers++;
      }

    } else {
      wrongAnswers++;
    }

    if (currentQuestion == quizQuestions.length - 1) {

      timer?.cancel();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            playerName: widget.playerName,
            score: score,
            correctAnswers: correctAnswers,
            wrongAnswers: wrongAnswers,
          ),
        ),
      );

      return;
    }

    setState(() {
      currentQuestion++;
      selectedAnswer = null;
    });

    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double progress =
        (currentQuestion + 1) / quizQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jogador: ${widget.playerName}",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            LinearProgressIndicator(
              value: progress,
            ),

            const SizedBox(height: 10),

            Text(
              "Tempo restante: $timeLeft segundos",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 400,
                ),
                child: QuestionCard(
                  key: ValueKey(currentQuestion),
                  question:
                      quizQuestions[currentQuestion],
                  questionNumber:
                      currentQuestion + 1,
                  selectedAnswer:
                      selectedAnswer,
                  onAnswerSelected: (value) {
                    setState(() {
                      selectedAnswer = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: nextQuestion,
                child: const Text(
                  "Próxima",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}