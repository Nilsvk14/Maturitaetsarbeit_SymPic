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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(image: AssetImage('assets/wave_t.png')),
            ),
            Logo(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(image: AssetImage('assets/wave_b.png')),
            ),
          ],
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Hero(
            tag: "title",
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Image(
                  image: AssetImage('assets/logo_sympic_simple_2.png'),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              Text(
                "Augmentative and Alternative",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                "Communication",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: FloatingActionButton.extended(
            heroTag: "simple_speech",
            label: Text(
              "Los geht's!",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SpeechView()),
              );
            },
          ),
        ),
      ],
    );
  }
}
