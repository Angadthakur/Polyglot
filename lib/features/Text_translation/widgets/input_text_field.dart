import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for clipboard functionality

class InputTextField extends StatefulWidget {
  const InputTextField({super.key});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  // A controller to manage the text in the TextField
  final _textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //height: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(12.0),

          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Translate from: English',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),

                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.copy_outlined),
                    tooltip: 'Copy Text',
                    onPressed: () {
                      // Copies the text from the controller to the clipboard
                      Clipboard.setData(
                        ClipboardData(text: _textController.text),
                      );
                      // Show a confirmation message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied to Clipboard')),
                      );
                      print("Text copied");
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: 'Clear Text',
                    onPressed: () {
                      // Clears the text field using the controller
                      _textController.clear();
                      print("Text cleared");
                    },
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),

              Expanded(
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  expands: true,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Enter text here...',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
