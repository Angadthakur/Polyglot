import 'package:flutter_test/flutter_test.dart';
import 'package:translator_app_polyglot/core/utils/constants.dart';

void main(){
  group('Supported Languages', (){
    test('supported languages list is not empty', () {
      expect(supportedLanguages, isNotEmpty);
    });

    test('every language has a non-empty name and code', () {
      for (final lang in supportedLanguages) {
        expect(lang.name, isNotEmpty,
            reason: 'Language name should not be empty');
        expect(lang.code, isNotEmpty,
            reason: 'Language code should not be empty');
      }
    });

    test('English is in the supported languages list', () {
      final hasEnglish = supportedLanguages.any(
        (lang) => lang.code == 'en',
      );
      expect(hasEnglish, isTrue,
          reason: 'English must always be a supported language');
    });

    test('no duplicate language codes exist', () {
      final codes = supportedLanguages.map((lang) => lang.code).toList();
      final uniqueCodes = codes.toSet();
      expect(codes.length, equals(uniqueCodes.length),
          reason: 'Each language code must be unique');
    });
  });
}