import 'package:flutter/material.dart';
import 'package:translator_app_polyglot/core/utils/constants.dart';
import 'package:translator_app_polyglot/features/Text_translation/screen/text_translation.dart';


class Language {
  final String name;
  final String code;

  const Language({required this.name, required this.code});
}

class LanguageSelector extends StatelessWidget {


  final String sourceLanguage;
  final String targetLanguageCode;
  final Function(String) onTargetLanguageChanged;
  final VoidCallback onSwapLanguages;

  const LanguageSelector({
    super.key,
    required this.sourceLanguage,
    required this.targetLanguageCode,
    required this.onTargetLanguageChanged,
    required this.onSwapLanguages,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            Expanded(
              child: Text(
                sourceLanguage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //Langauge swap button
            IconButton(
              icon: const Icon(Icons.swap_horiz_rounded),
              onPressed: onSwapLanguages,
              tooltip: 'Swap languages',
            ),

            
            Expanded(
              child: DropdownButton<String>(
                value: targetLanguageCode,
                isExpanded: true,
                underline: const SizedBox(), 
                icon: const Icon(Icons.arrow_drop_down_rounded),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onTargetLanguageChanged(newValue);
                  }
                },
                items: supportedLanguages.map<DropdownMenuItem<String>>((Language language) {
                  return DropdownMenuItem<String>(
                    value: language.code,
                    child: Center(
                      child: Text(
                        language.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
