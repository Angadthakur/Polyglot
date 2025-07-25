import 'package:flutter/material.dart';
import 'package:translator_app_polyglot/features/Voice_translation/widgets/microphone_button.dart';
import 'package:translator_app_polyglot/features/presentation/screens/homescreen.dart';

class VoiceTranslationScreen extends StatefulWidget {
  const VoiceTranslationScreen({super.key});

  @override
  State<VoiceTranslationScreen> createState() => _VoiceTranslationScreenState();
}

class _VoiceTranslationScreenState extends State<VoiceTranslationScreen> {
  bool _isListening = false; // The state variable

  void _handleMicTap() {
    // This function toggles the state
    setState(() {
      _isListening = !_isListening;
    });

    if (_isListening) {
      // TODO: Start the speech recognition process
      print("Started listening...");
    } else {
      // TODO: Stop the speech recognition process
      print("Stopped listening.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Homescreen()));

        print("Back to Home Screen");
          
          } , 
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
          )),
        titleSpacing:40,

        title: const Text(
          'Voice Translation',
          style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontStyle: FontStyle.italic
                ),
        )),
        
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(), // Pushes the button to the bottom area
            Text(
              _isListening ? "Listening..." : "Tap the mic to start",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            // Use your custom widget here
            MicrophoneButton(
              isListening: _isListening,
              onTap: _handleMicTap,
            ),
            const SizedBox(height: 50), // Some padding from the bottom
          ],
        ),
      ),
    );
  }
}