import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/i18n/strings.dart';

class ErrorView<TBloc extends BlocBase> extends StatelessWidget {
  final errorText;
  final void Function() reloadCallback;
  final Color errorTextColor;

  const ErrorView(
    this.errorText, {
    this.reloadCallback,
    this.errorTextColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    String message;
    if (errorText is SocketException) {
      message = Strings.of(context).textNoInternet;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            message ?? errorText.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: errorTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (reloadCallback != null) _buildReloadButton(),
      ],
    );
  }

  Widget _buildReloadButton() {
    return Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: RaisedButton(
          child: Text(Strings.of(context).textRetry),
          onPressed: reloadCallback,
        ),
      );
    });
  }
}
