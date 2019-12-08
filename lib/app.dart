import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/api/api_client.dart';
import 'package:flutter_app/ui/styles/app_colors.dart';

import 'i18n/strings.dart';
import 'storage.dart';
import 'ui/pages/main/main_page.dart';
import 'ui/pages/main/main_page_bloc.dart';

class App extends StatelessWidget {
  void _setPortraitOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _setPortraitOnly();
    return BlocProvider(
      blocs: [
        Bloc((i) => MainPageBloc(i.get<ApiClient>())),
      ],
      dependencies: [
        Dependency((Inject i) => ApiClient(context)),
      ],
      child: _buildApp(context),
    );
  }

  Widget _buildApp(BuildContext context) {
    return StreamBuilder<String>(
      stream: Storage().languageSubject.stream,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.of(context).appName,
          theme: ThemeData(
            primarySwatch: AppColors.of(context).primaryColor,
          ),
          home: MainPage(),
        );
      },
    );
  }
}
