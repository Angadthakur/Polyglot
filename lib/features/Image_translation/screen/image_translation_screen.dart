import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 

class ImageTranslationScreen extends StatefulWidget {
  const ImageTranslationScreen({super.key});

  @override
  State<ImageTranslationScreen> createState() => _ImageTranslationScreenState();
}

class _ImageTranslationScreenState extends State<ImageTranslationScreen> {

  File? _selectedImage; 
  bool _isProcessing = false; 

  

  // This function now contains the logic to pick an image from the gallery.
  Future<void> _pickImageFromGallery() async {
    // 2. Create an instance of the picker
    final ImagePicker picker = ImagePicker();
    // 3. Use the picker to pick an image from the gallery
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // 4. Check if the user actually picked a file
    if (pickedFile != null) {
      // 5. Update the state to display the new image
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      print("No image selected.");
    }
  }

  // This function now contains the logic to take a picture with the camera.
  Future<void> _pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

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
    setState(() { _isProcessing = true; });
    print("Translating image...");
    // ...
  }


  // --- BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 52, 210),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Image Translation',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
                            Icon(Icons.add_a_photo_outlined, size: 80, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Select an image to begin',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
            ),
            
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImageFromCamera,
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text('Camera'),
                  style: ElevatedButton.styleFrom(
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Gallery'),
                   style: ElevatedButton.styleFrom(
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
