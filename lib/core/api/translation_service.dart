import 'package:translator/translator.dart';

class TranslationService {
 Future <String > translate(String textToTranslate , String targetLanguageCode ) async{
  final translator = GoogleTranslator();
  final translationResult = await translator.translate(textToTranslate , to: targetLanguageCode);

  return translationResult.text;

}

}