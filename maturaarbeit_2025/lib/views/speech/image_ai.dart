import 'package:flutter/material.dart';
import 'package:maturaarbeit_2025/views/speech/image_ai_service.dart';
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class ImageAiSpeech extends StatefulWidget {
  const ImageAiSpeech({super.key});

  @override
  State<ImageAiSpeech> createState() => _ImageAiSPeechState();
}

class _ImageAiSPeechState extends State<ImageAiSpeech> {
  bool _isOnline = false;
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  bool _loading = false;
  bool _canListen = true;
  final List<SymbolData> _symbols = [];

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final result = await (Connectivity().checkConnectivity());
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      setState(() {
        _isOnline = true;
      });
    }
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    if (!mounted) return;
    final errorSnackBar = SnackBar(
      content: Text(
        'Spracheingabe nicht möglich. Bitte überprüfe die Berechtigungen der App.',
      ),
    );
    if (_speechEnabled) {
      if (!_canListen) return;

      _lastWords = '';

      await _speechToText.listen(onResult: _onSpeechResult);
      if (!mounted) return;
      setState(() {});

      // Timeout, if nothing is said
      Future.delayed(const Duration(seconds: 5), () async {
        if (_speechToText.isListening && _lastWords.trim().isEmpty) {
          await _speechToText.stop();
          _handleSpeechFinished();
          if (!mounted) return;
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
      if (!mounted) return;
      await _speechToText.stop();
    }
    _handleSpeechFinished();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    if (!mounted) return;
    if (_speechToText.lastStatus == 'notListening') {
      _handleSpeechFinished();
    }
  }

  void _handleSpeechFinished() async {
    if (_loading) return;
    if (!mounted) return;
    if (_lastWords.isEmpty) {
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
    if (!mounted) return;
    setState(() {
      _loading = true;
      _canListen = false;
    });

    await _getArasaacImages(_lastWords);
    if (!mounted) return;
    setState(() {
      _loading = false;
      _canListen = true;
    });
  }

  Future<void> _getArasaacImages(String sentence) async {
    _symbols.clear();

    if (!_isOnline) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Keine Verbindung möglich. Bitte überprüfe deine Internetverbindung.',
            ),
          ),
        );
        setState(() {
          _loading = false;
          _canListen = true;
        });
      }
    } else {
      try {
        final List<List<String>> result = await imageAi(sentence);

        final List<String> aacWords = result[0];
        final List<String> translatedPrompt = result[1];

        for (int i = 0; i < aacWords.length; i++) {
          final word = aacWords[i];

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
            final imageUrl = await imageCreation(translatedPrompt[i]);
            _symbols.add(SymbolData(word: word, imageUrl: imageUrl));
          }
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
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (_loading)
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.stretchedDots(
                    color: Theme.of(context).colorScheme.primary,
                    size: MediaQuery.of(context).size.width / 3,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Die Piktogramme werden generiert. Dieser Vorgang kann einige Sekunden dauern.",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            )
          else
            !_speechToText.isListening
                ? _symbols.isEmpty
                      ? Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge
                                              ?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                          children: const [
                                            TextSpan(text: "Piktogramme "),
                                            TextSpan(
                                              text: "mit",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(text: " KI"),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 12,
                                        bottom: 40,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "Ergänzende Piktogramme zur Übersetzung mit KI",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Colors.grey[700],
                                                  ),
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 35,
                                ),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "So funktioniert's:",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                          ),
                                        ),
                                        Text(
                                          "1. Kurz auf das Mikrofon drücken.",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                          ),
                                        ),
                                        Text(
                                          "2. Sag deinen Satz.",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                          ),
                                        ),
                                        Text(
                                          "3. KI verbessert deinen Satz.",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                          ),
                                        ),
                                        Text(
                                          "4. Fehlende Piktogramme werden von der KI generiert.",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                          ),
                                        ),
                                        Text(
                                          "5. Passende Piktogramme werden dir angezeigt.",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(flex: 8, child: SymbolGrid(symbols: _symbols))
                : Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: Theme.of(context).colorScheme.primary,
                          size: MediaQuery.of(context).size.width / 2.5,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Sage deinen Satz.",
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 13.0, top: 2),
                  child: FloatingActionButton(
                    heroTag: "image_ai",
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
