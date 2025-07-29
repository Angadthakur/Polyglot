import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator_app_polyglot/core/api/translation_service.dart';
import 'package:translator_app_polyglot/core/utils/constants.dart';
import 'package:translator_app_polyglot/features/Text_translation/widgets/input_text_field.dart';
import 'package:translator_app_polyglot/features/Text_translation/widgets/translated_text_field.dart';
import 'package:translator_app_polyglot/features/presentation/screens/homescreen.dart';
import 'package:translator_app_polyglot/core/widgets/language_selector.dart';


class TextTranslation extends StatefulWidget {
  const TextTranslation({super.key});

  @override
  State<TextTranslation> createState() => _TextTranslationState();
}

class _TextTranslationState extends State<TextTranslation> {
  //STATE MANAGEMENT
  final TranslationService _translationService = TranslationService();

  final TextEditingController _textController = TextEditingController();

  final FlutterTts _flutterTts = FlutterTts();

  String _sourceLanguage = 'Auto Detect';
  String _targetLanguageCode = 'es';
  String _targetLanguageName = 'Spanish';
  String _translatedText = "Translation will appear here";

  bool _isLoading = false;

  @override
  void dispose() {
    //Clean up the controller when the screen is closed
    _textController.dispose();
    super.dispose();
  }

  //TRANSLATION LOGIC
  Future<void> _onTranslatePressed() async {
    if (_textController.text.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus(); //to hide the keyboard

    setState(() {
      _isLoading = true; //to show the loading indicator
    });

    try {
      final result = await _translationService.translate(
        _textController.text,
        _targetLanguageCode,
        
      );
      setState(() {
        _translatedText = result.text;
        _sourceLanguage = result.sourceLanguage.name;
      });
    } catch (e) {
      setState(() {
        _translatedText = "Error: Could not translate.";
      });
      print(e);
    } finally {
      setState(() {
        _isLoading =
            false; //to hide the loading indicator , regardless of success or error
      });
    }
  }

  void _onTargetLanguageChanged(String newCode){
    setState(() {
      _targetLanguageCode = newCode;
      _targetLanguageName = supportedLanguages.firstWhere((lang)=> lang.code == newCode).name;
    });
  }

  void _onSwapLanguages(){
    if(_sourceLanguage == "Auto Detect" || _textController.text.trim().isEmpty){
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Translate something first to enable swap!')),
      );
      return;
    }
    try{
      final sourceLangCode = supportedLanguages.firstWhere((lang) => lang.name == _sourceLanguage).code;
      setState(() {
  
  final tempSourceLangName = _sourceLanguage;
  final tempTargetLangCode = _targetLanguageCode;
  final tempTargetLangName = _targetLanguageName;
  final tempInputText = _textController.text;
  final tempTranslatedText = _translatedText;

  
  _sourceLanguage = tempTargetLangName;

  
  _targetLanguageCode = sourceLangCode; 
  _targetLanguageName = tempSourceLangName;

  
  _textController.text = tempTranslatedText;
  _translatedText = tempInputText;
});
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot swap: Language not supported for selection.')),
      );
      print("Could not find the source language in the supported list: $e");
          }
  }

  //Text-to-speech Logic
   Future<void> _onListenPressed() async {
    
    if (_translatedText.isEmpty || _translatedText == "Translation will appear here..." || _translatedText.startsWith("Error:")) {
      print("Nothing to speak.");
      return;
    }

    try {
      
      await _flutterTts.setLanguage(_targetLanguageCode);
      
      await _flutterTts.setSpeechRate(0.5);
      
      await _flutterTts.speak(_translatedText);
    } catch (e) {
      print("Error with TTS: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Text-to-speech is not available for this language.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          186,
          52,
          210,
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();

            print("Back to Home Screen");
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        titleSpacing: 30,

        title: const Text(
          "Text Translation",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontStyle: FontStyle.italic,
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
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LanguageSelector(
                  sourceLanguage: _sourceLanguage,
                  targetLanguageCode: _targetLanguageCode, 
                  onTargetLanguageChanged: _onTargetLanguageChanged, 
                  onSwapLanguages: _onSwapLanguages
                ),
          
                Expanded(
                  flex: 2,
                  child: InputTextField(
                  controller: _textController,
                  sourceLanguage: _sourceLanguage)),
          
                Padding(
                  
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton.icon(
                          onPressed: _onTranslatePressed,
                          icon: const Icon(Icons.translate),
                          label: const Text("Translate"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color.fromARGB(
                              255,
                              186,
                              52,
                              210,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
          
                Expanded(
                  flex: 2,
                  child: TranslatedTextField(
                    translatedText: _translatedText,
                    targetLanguage: _targetLanguageName,
                    onListenPressed: (){
          
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


