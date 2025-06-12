import 'package:flutter/material.dart';
import 'package:maturaarbeit_2025/views/speech_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton(
        child: Text("Speech to picto"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SpeechView()),
          );
        },
      ),
    );
  }
}
