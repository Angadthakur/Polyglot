import 'package:flutter/material.dart';

class MicrophoneButton extends StatelessWidget {
  final bool isListening;
  final VoidCallback onTap;

  const MicrophoneButton({
    super.key,
    required this.isListening,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Defined colors based on the listening state
    final buttonColor = isListening ? Colors.red.shade400 : const Color.fromARGB(255, 186, 52, 210);
    final iconColor = Colors.white;

    return SizedBox(
      // Defined a fixed size for the button area
      width: 120,
      height: 150,
      child: Material(
        color: buttonColor,
        // Use a circular shape
        shape: const CircleBorder(),
        // Add elevation for a shadow effect
        elevation: 8.0,
        // Use InkWell for the ripple effect on tap
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Center(
            // The icon changes based on the listening state
            child: Icon(
              isListening ? Icons.stop_rounded : Icons.mic_rounded,
              size: 60,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
