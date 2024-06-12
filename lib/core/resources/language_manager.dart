// ignore_for_file: constant_identifier_names

enum LanguageType { ENGLISH, TURKISH }

const String ENGLISH = 'en';
const String TURKISH = 'tr';

extension LanguageTypeExtension on LanguageType {
  String getLanguage() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.TURKISH:
        return TURKISH;
    }
  }
}
