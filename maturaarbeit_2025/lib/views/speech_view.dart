import 'package:flutter/material.dart';
import 'package:maturaarbeit_2025/views/info.dart';
import 'package:maturaarbeit_2025/views/simple_speech.dart';

class SpeechView extends StatefulWidget {
  const SpeechView({super.key});

  @override
  State<SpeechView> createState() => _SpeechViewState();
}

class _SpeechViewState extends State<SpeechView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
              icon: Icon(Icons.info_outline),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.record_voice_over)),
              Tab(icon: Icon(Icons.assistant)),
              Tab(icon: Icon(Icons.photo_library)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SimpleSpeech(),
            Icon(Icons.assistant),
            Icon(Icons.photo_library),
          ],
        ),
      ),
    );
  }
}
