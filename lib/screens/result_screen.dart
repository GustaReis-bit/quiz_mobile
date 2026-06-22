import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final String playerName;
  final int score;
  final int correctAnswers;
  final int wrongAnswers;

  const ResultScreen({
    super.key,
    required this.playerName,
    required this.score,
    required this.correctAnswers,
    required this.wrongAnswers,
  });

  String getMessage(double percentage) {
    if (percentage >= 90) {
      return "Excelente! Você domina Desenvolvimento Mobile.";
    }

    if (percentage >= 70) {
      return "Muito bom! Continue praticando.";
    }

    if (percentage >= 50) {
      return "Bom trabalho, mas ainda há espaço para melhorias.";
    }

    return "Continue estudando e tente novamente.";
  }

  @override
  Widget build(BuildContext context) {
    double percentage = (correctAnswers / 10) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultado"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Icon(
                    Icons.emoji_events,
                    size: 100,
                    color: Colors.amber,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    playerName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text("Acertos: $correctAnswers"),
                  Text("Erros: $wrongAnswers"),
                  Text("Nota Final: $score/10"),
                  Text(
                    "Aproveitamento: ${percentage.toStringAsFixed(0)}%",
                  ),

                  const SizedBox(height: 20),

                  Text(
                    getMessage(percentage),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text("Jogar Novamente"),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}