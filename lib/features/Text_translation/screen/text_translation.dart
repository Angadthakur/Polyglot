import 'package:flutter/material.dart';
import 'package:translator_app_polyglot/core/api/translation_service.dart';
import 'package:translator_app_polyglot/features/Text_translation/widgets/input_text_field.dart';
import 'package:translator_app_polyglot/features/Text_translation/widgets/translated_text_field.dart';
import 'package:translator_app_polyglot/features/presentation/screens/homescreen.dart';

class TextTranslation extends StatefulWidget {
  const TextTranslation({super.key});

  @override
  State<TextTranslation> createState() => _TextTranslationState();
}

class _TextTranslationState extends State<TextTranslation> {
  //STATE MANAGEMENT 
  final TranslationService _translationService = TranslationService();

  final TextEditingController _textController = TextEditingController();

  String _translatedText = "Translation will appear here";

  bool _isLoading = false;

  @override
  void dispose(){
     //Clean up the controller when the screen is closed
     _textController.dispose();
     super.dispose();
  }

  //TRANSLATION LOGIC
  Future <void> _onTranslatePressed() async{
    if(_textController.text.trim().isEmpty){
      return;
    }

    FocusScope.of(context).unfocus(); //To hide the keyboard

    setState(() {
      _isLoading = true; // to show the loading indicator 
    });

    try{
      final result = await _translationService.translate(
        _textController.text,
        "es",
      );
      setState(() {
        _translatedText = result;
      });

    }catch(e){
      setState(() {
        _translatedText ="Error: Could not translate.";
      });
      print(e);
    }finally{
      setState(() {
        _isLoading = false; // to hide the loading indicator , regardless of success or error
      });
    }
  }

  //Text-to-speech Logic 
  void _onListenPressed(){
    //TODO
    print("Listen button tapped. Text: $_translatedText");
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,

      
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 186, 52, 210), // Match your theme
        elevation: 0,
        leading:IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          
          

        print("Back to Home Screen");
          
        }, 
        icon:const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
          size: 30,
          
        )
        ),
        titleSpacing:40,

        title: const Text(
          "Text Translation",
          style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontStyle: FontStyle.italic
                ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
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
            children:[
              Expanded(
                child:InputTextField(controller: _textController), 
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white,)
                  : ElevatedButton.icon(onPressed: _onTranslatePressed, 
                  icon: const Icon(Icons.translate),
                  label: const Text("Translate"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 186, 52, 210),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ), 
                ),

                Expanded(
                  child: TranslatedTextField(
                   translatedText: _translatedText,
                   targetLanguage: "Spanish",
                   onListenPressed: _onListenPressed,
                  )
                )
              
            ],
          )),
      ),
    );
  }
}