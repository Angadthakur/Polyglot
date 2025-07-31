import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService {
  Future<String> recognizeText(File imageFile) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      final inputImage = InputImage.fromFilePath(imageFile.path);

      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      final String extractedText = recognizedText.text;

      return extractedText;
    } catch (e) {
      print("Error recognizing text : $e");
      return "Error : Could not recognize text from the image";
    } finally {
      textRecognizer.close();
    }
  }
}
