import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  void startQuiz() {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Digite seu nome."),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            QuizScreen(playerName: nameController.text.trim()),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void newMatch() {
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Mobile"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width > 600 ? 500 : double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [

                const Icon(
                  Icons.phone_android,
                  size: 120,
                  color: Colors.blue,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Quiz Mobile",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Teste seus conhecimentos em Desenvolvimento Mobile",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Nome do Jogador",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: startQuiz,
                    child: const Text("Iniciar Quiz"),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: newMatch,
                    child: const Text("Nova Partida"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}