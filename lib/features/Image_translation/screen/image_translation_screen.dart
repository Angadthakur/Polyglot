import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  void _translateImage() {
    if (_selectedImage == null) return;
    setState(() {
      _isProcessing = true;
    });
    print("Translating image...");

    //FAKE:Simulate a delay for API calls
    Future.delayed(const Duration(seconds: 2), () {
      String fakeRecognizedText = "This text was found on the image.";
      String fakeTranslatedText = "Este texto fue encontrado en la imagen.";

      setState(() {
        _isProcessing = false;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImageResultScreen(
            recognizedText: fakeRecognizedText,
            translatedText: fakeTranslatedText,
          ),
        ),
      );
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Homescreen()),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
            color: Colors.black,
          ),
        ),
        titleSpacing: 40,
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
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _selectedImage == null
                    ? const Center(
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
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.file(_selectedImage!, fit: BoxFit.contain),
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
