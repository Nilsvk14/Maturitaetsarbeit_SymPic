import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SimpleSpeech extends StatefulWidget {
  const SimpleSpeech({super.key});

  @override
  State<SimpleSpeech> createState() => _SimpleSpeechState();
}

class _SimpleSpeechState extends State<SimpleSpeech> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  bool _loading = false;
  bool _canListen = true;
  List<String> _spokenWords = [];

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
    final errorSnackBar = SnackBar(
      content: Text(
        'Spracheingabe nicht möglich. Bitte überprüfe die Berechtigungen der App.',
      ),
    );
    if (_speechEnabled) {
      if (!_canListen) return;

      _lastWords = '';
      _spokenWords.clear();
      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {});

      // Timeout, if nothing is said
      Future.delayed(const Duration(seconds: 5), () async {
        if (_speechToText.isListening && _lastWords.trim().isEmpty) {
          await _speechToText.stop();
          _handleSpeechFinished();
          setState(() {
            _loading = false;
            _canListen = true;
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
  }

  void _stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
    }
    _handleSpeechFinished();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;

    if (_speechToText.lastStatus == 'notListening') {
      _handleSpeechFinished();
    }
  }

  void _handleSpeechFinished() async {
    if (_loading) return;

    _spokenWords = _lastWords
        .toLowerCase()
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    if (_spokenWords.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Keine Sprache erkannt. Bitte erneut versuchen.'),
          ),
        );
        setState(() {
          _loading = false;
          _canListen = true;
        });
      }
      return;
    }

    setState(() {
      _loading = true;
      _canListen = false;
    });

    await _fetchFromArasaac(_spokenWords);

    setState(() {
      _loading = false;
      _canListen = true;
    });
  }

  Future<void> _fetchFromArasaac(List<String> words) async {
    print("📡 ARASAAC API wird abgefragt für: $words");
    await Future.delayed(const Duration(seconds: 5)); // simuliert den API-Call
    print("✅ ARASAAC Antwort erhalten.");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (_loading)
            LoadingAnimationWidget.stretchedDots(
              color: Theme.of(context).colorScheme.primary,
              size: MediaQuery.of(context).size.width / 3,
            )
          else
            !_speechToText.isListening
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "So funktioniert's:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "1. Auf das Mikrofon drücken",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text("2. Sprechen", style: TextStyle(fontSize: 18)),
                            Text(
                              "3. Übersetzung wird angezeigt",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : LoadingAnimationWidget.staggeredDotsWave(
                    color: Theme.of(context).colorScheme.primary,
                    size: MediaQuery.of(context).size.width / 2.5,
                  ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: _canListen
                    ? (_speechToText.isNotListening
                          ? _startListening
                          : _stopListening)
                    : null,
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
