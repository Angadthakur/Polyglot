import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator_app_polyglot/core/api/ocr_service.dart';
import 'package:translator_app_polyglot/core/api/translation_service.dart';
import 'package:translator_app_polyglot/core/utils/constants.dart';
import 'package:translator_app_polyglot/core/widgets/language_selector.dart';
import 'package:translator_app_polyglot/features/Image_translation/screen/image_result_screen.dart';
import 'package:translator_app_polyglot/features/presentation/screens/homescreen.dart';

class ImageTranslationScreen extends StatefulWidget {
  const ImageTranslationScreen({super.key});

  @override
  State<ImageTranslationScreen> createState() => _ImageTranslationScreenState();
}

class _ImageTranslationScreenState extends State<ImageTranslationScreen> {
  File? _selectedImage;
  bool _isProcessing = false;

  final OcrService _ocrService = OcrService();
  final TranslationService _translationService = TranslationService();

  String _targetLanguageCode = "en";
  String _targetLanguageName = "English";

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      print("No image selected.");
    }
  }

  Future<void> _pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      print("No image taken.");
    }
  }

  Future<void> _translateImage() async {
    if (_selectedImage == null) return;
    setState(() {
      _isProcessing = true;
    });
    try {
      final recognizedText = await _ocrService.recognizeText(_selectedImage!);

      if (recognizedText.trim().isEmpty ||
          recognizedText.startsWith("Error:")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not find any text in the image")),
        );
        setState(() {
          _isProcessing = false;
        });
        return;
      }

      final translationResult = await _translationService.translate(
        recognizedText,
        _targetLanguageCode,
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImageResultScreen(
            recognizedText: recognizedText,
            translatedText: translationResult.text,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred during translation.")),
      );
      print("Error during image translation process : $e");
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _onTargetLanguageChanged(String newCode){
    setState(() {
      _targetLanguageCode = newCode;
      _targetLanguageName = supportedLanguages.firstWhere((lang) => lang.code == newCode).name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 52, 210),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const Homescreen()));
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
        titleSpacing: 30,
        title: const Text(
          'Image Translation',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  children: [
                    const Text(
                      'Translate To:',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      value: _targetLanguageCode,
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          _onTargetLanguageChanged(newValue);
                        }
                      },
                      items: supportedLanguages.map<DropdownMenuItem<String>>((Language language) {
                        return DropdownMenuItem<String>(
                          value: language.code,
                          child: Text(
                            language.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),            
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_selectedImage == null)
                      const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              size: 80,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Select an image to begin',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.file(_selectedImage!, fit: BoxFit.contain),
                      ),
                    if (_isProcessing) const CircularProgressIndicator(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (_selectedImage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton.icon(
                  onPressed: _translateImage,
                  label: const Text("Translate Image"),
                  icon: const Icon(Icons.translate),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 186, 52, 210),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            if (_selectedImage == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImageFromCamera,
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Camera'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickImageFromGallery,
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text('Gallery'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
