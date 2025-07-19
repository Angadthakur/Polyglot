import 'package:flutter/material.dart';
import 'package:translator_app_polyglot/features/Text_translation/screen/text_translation.dart';
import 'package:translator_app_polyglot/features/presentation/widgets/feature_card.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Polyglot",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 45,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black, size: 30),
            onPressed: () {
              //TODO: Navigate to setting page
              print("Settings Tapped!");
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              const Color.fromARGB(255, 218, 167, 227),
              const Color.fromARGB(255, 186, 52, 210),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),

              Image.asset('assets/languages.png', height: 120, width: 120),

              SizedBox(height: 40),

              FeatureCard(
                title: "Text Translation",
                subtitle: "Type or paste any text to translate instantly.",
                icon: Icons.text_fields,
                onTap: () {
                  //Navigate to the Text Translation screen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const TextTranslation(),
                    ),
                  );
                  print("Text Translation Tapped!");
                },
              ),
              FeatureCard(
                title: 'Voice Translation',
                subtitle: "Speak into your mic for a real-time translation.",
                icon: Icons.mic,
                onTap: () {
                  // TODO: Navigate to the Voice Translation screen
                  print('Voice Translation Tapped!');
                },
              ),
              FeatureCard(
                title: 'Image Translation',
                subtitle:
                    "Use your camera to translate text from the world around you.",
                icon: Icons.camera_alt,
                onTap: () {
                  // TODO: Navigate to the Image Translation screen
                  print('Image Translation Tapped!');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
