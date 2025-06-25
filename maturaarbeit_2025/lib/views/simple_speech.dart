import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class SimpleSpeech extends StatefulWidget {
  const SimpleSpeech({super.key});

  @override
  State<SimpleSpeech> createState() => _SimpleSpeechState();
}

class _SimpleSpeechState extends State<SimpleSpeech> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

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
                    Text(
                      _speechToText.isListening
                          ? "$_lastWords"
                          : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: _speechToText.isNotListening
                    ? _startListening
                    : _stopListening,
                child: Icon(
                  _speechToText.isNotListening ? Icons.mic : Icons.mic_off,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
