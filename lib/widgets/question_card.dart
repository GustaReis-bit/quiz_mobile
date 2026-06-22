import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int questionNumber;
  final String? selectedAnswer;
  final Function(String) onAnswerSelected;

  const QuestionCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Text(
              "Questão $questionNumber",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              question.question,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            ...question.options.map(
              (option) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: RadioListTile<String>(
                  value: option,
                  groupValue: selectedAnswer,
                  title: Text(option),
                  onChanged: (value) {
                    onAnswerSelected(value!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}