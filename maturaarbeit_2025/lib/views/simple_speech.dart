import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

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
  final List<SymbolData> _symbols = [];

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

    await _getArasaacImages(_spokenWords);

    setState(() {
      _loading = false;
      _canListen = true;
    });
  }

  Future<void> _getArasaacImages(List<String> words) async {
    _symbols.clear();
    print(words);
    for (final word in words) {
      try {
        final response = await http.get(
          Uri.parse(
            'https://api.arasaac.org/api/pictograms/de/bestsearch/$word',
          ),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          if (data.isNotEmpty) {
            final id = data.first['_id'];
            final imageUrl =
                'https://static.arasaac.org/pictograms/$id/${id}_300.png';
            _symbols.add(SymbolData(word: word, imageUrl: imageUrl));
          }
        } else {
          _symbols.add(SymbolData(word: word, imageUrl: ''));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Keine Verbindung zur Piktogrammsammlung möglich. Versuche es später nochmal.',
              ),
            ),
          );
          setState(() {
            _loading = false;
            _canListen = true;
          });
        }
      }
    }

    setState(() {});
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
                ? _symbols.isEmpty
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
                                  Text(
                                    "2. Sprechen",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "3. Übersetzung wird angezeigt",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Expanded(child: SymbolGrid(symbols: _symbols))
                : LoadingAnimationWidget.staggeredDotsWave(
                    color: Theme.of(context).colorScheme.primary,
                    size: MediaQuery.of(context).size.width / 2.5,
                  ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 8),
                child: FloatingActionButton(
                  onPressed: _canListen
                      ? (_speechToText.isNotListening
                            ? _startListening
                            : _stopListening)
                      : null,
                  child: Icon(
                    _speechToText.isNotListening ? Icons.mic : Icons.mic_off,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SymbolData {
  final String word;
  final String imageUrl;

  SymbolData({required this.word, required this.imageUrl});
}

class SymbolGrid extends StatelessWidget {
  final List<SymbolData> symbols;

  const SymbolGrid({super.key, required this.symbols});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: symbols.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (MediaQuery.of(context).size.width ~/ 180).clamp(2, 4),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        print(symbols.length);
        final symbol = symbols[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              symbol.imageUrl != ''
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.network(
                          symbol.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  symbol.word,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
