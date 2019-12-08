import 'package:flutter/material.dart';

import '../storage.dart';
import 'languages/en_strings.dart';
import 'utils/language_codes.dart';

abstract class Strings {
  factory Strings.of(BuildContext context) {
    String code = Storage().getLanguageCodeSync() ??
        Localizations.localeOf(context, nullOk: true)?.languageCode ??
        LanguageCodes.defaultCode;
    switch (code) {
      case LanguageCodes.en:
      default:
        return EnStrings();
        break;
    }
  }

  String get languageName;

  String get appName;

  String get loremIpsum;

  String get textNoInternet;

  String get textRetry ;
}
