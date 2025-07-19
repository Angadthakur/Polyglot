import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TranslatedTextField extends StatelessWidget {
  final String translatedText;

  const TranslatedTextField({super.key, required this.translatedText});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      color: Colors.white, 
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'To: Spanish', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy_outlined),
                  tooltip: 'Copy Translation',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: translatedText));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to Clipboard')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up_outlined),
                  tooltip: 'Listen',
                  onPressed: () {
                    // TODO: Add Text-to-Speech functionality
                    print("Text-to-speech tapped");
                  },
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity, // Ensures text aligns left
                  child: Text(
                    translatedText,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
