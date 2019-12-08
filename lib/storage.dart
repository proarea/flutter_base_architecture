import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'i18n/utils/language_codes.dart';

class Storage {
  static final Storage _instance = Storage._internal();

  factory Storage() => _instance;

  Storage._internal();

  String _languageCode;

  static const _LANGUAGE_CODE = 'LANGUAGE_CODE';

  Future<SharedPreferences> get _preferences => SharedPreferences.getInstance();

  Future<void> setLanguageCode(String languageCode) async {
    _languageCode = languageCode;
    return _preferences.then((storage) {
      storage.setString(_LANGUAGE_CODE, languageCode);
    });
  }

  // ignore: close_sinks
  final BehaviorSubject<String> _languageSubject = BehaviorSubject<String>.seeded(
    LanguageCodes.defaultCode,
  );

  BehaviorSubject<String> get languageSubject => _languageSubject;

  void changeLanguage(String newLanguageCode) async {
    String newCode = LanguageCodes.supportedLocales.contains(newLanguageCode)
        ? newLanguageCode
        : LanguageCodes.defaultCode;
    await setLanguageCode(newCode);
    _languageSubject.sink.add(newCode);
  }

  String getLanguageCodeSync() => _languageCode;

  Future loadLanguageCode() async {
    _languageCode = await getLanguageCode();
  }

  Future<String> getLanguageCode() async {
    return _preferences.then<String>((storage) {
      return storage.getString(_LANGUAGE_CODE);
    });
  }

  Future<String> getToken() {
    return Future.value("token");
  }

  Future<void> clearStorage() async {
    return _preferences.then<void>((storage) {
      return storage.clear();
    });
  }
}
