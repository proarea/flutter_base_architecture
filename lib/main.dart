import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import 'app.dart';
import 'storage.dart';

void main() async {
  await Future.wait([
    _setupLanguage(),
    _setupDatabase(),
    _setupLogging(),
  ]);

  _setupLogging();

  runApp(App());
}

Future<void> _setupLanguage() async {
  await Storage().loadLanguageCode();
}

Future<void> _setupDatabase() async {
//  SqfliteAdapter adapter = SqfliteAdapter(BuildConfig.dbName, version: BuildConfig.dbVersion);
//  await adapter.connect();
}

Future<void> _setupLogging() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
    (LogRecord rec) => print('${rec.level.name}: ${rec.time}: ${rec.message}'),
  );
}
