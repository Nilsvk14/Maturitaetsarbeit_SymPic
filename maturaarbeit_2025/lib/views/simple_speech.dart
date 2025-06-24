import 'package:flutter/material.dart';

class SimpleSpeech extends StatefulWidget {
  const SimpleSpeech({super.key});

  @override
  State<SimpleSpeech> createState() => _SimpleSpeechState();
}

class _SimpleSpeechState extends State<SimpleSpeech> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text("So funktioniert's:"),
                    ),
                    Text("1. Sprechen"),
                    Text("2. Piktogramme werden gesucht"),
                    Text("3. Übersetzung wird angezeigt"),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(child: Icon(Icons.mic), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
