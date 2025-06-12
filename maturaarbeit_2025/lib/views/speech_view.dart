import 'package:flutter/material.dart';
import 'package:maturaarbeit_2025/views/info.dart';

class SpeechView extends StatefulWidget {
  const SpeechView({super.key});

  @override
  State<SpeechView> createState() => _SpeechViewState();
}

class _SpeechViewState extends State<SpeechView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("SymPic"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InfoView()),
              );
            },
            icon: Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
