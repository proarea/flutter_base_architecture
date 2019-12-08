import 'package:flutter/material.dart';

class FieldData {
  final FocusNode node = FocusNode();
  final TextEditingController controller = TextEditingController();

  String errorText;

  FieldData();

  FieldData.withError(this.errorText);
}

class StandardField extends StatelessWidget {
  final FieldData fieldData;
  final String labelText;
  final bool obscuredText;
  final EdgeInsets additionalPadding;

  final FocusNode nextFocus;
  final VoidCallback onDone;

  final Color activeColor;
  final Color inactiveColor;

  final Color activeErrorColor;
  final Color inactiveErrorColor;
  final Color labelColor;

  /// [nextFocus] is valid ONLY if [onDone] is `null`
  const StandardField({
    @required this.fieldData,
    @required this.labelText,
    @required this.activeColor,
    @required this.inactiveColor,
    @required this.activeErrorColor,
    @required this.inactiveErrorColor,
    @required this.labelColor,
    this.nextFocus,
    this.onDone,
    bool obscuredText,
    this.additionalPadding,
  }) : obscuredText = obscuredText ?? false;

  TextInputAction getTextInputAction() {
    if (onDone != null) {
      return TextInputAction.done;
    } else if (nextFocus != null) {
      return TextInputAction.next;
    }
    return TextInputAction.done;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldData.controller,
      focusNode: fieldData.node,
      style: createTextFieldStyle(),
      cursorColor: activeColor,
      decoration: createInputDecoration(
        context,
        labelText: labelText,
        errorText: fieldData.errorText,
        contentPadding:
            EdgeInsets.only(top: 4, bottom: 16).add(additionalPadding ?? EdgeInsets.zero),
      ),
      textInputAction: getTextInputAction(),
      obscureText: obscuredText ?? false,
      onEditingComplete: () {
        if (onDone != null) {
          onDone();
        } else if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
    );
  }

  TextStyle createTextFieldStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w700,
    );
  }

  InputDecoration createInputDecoration(
    BuildContext context, {
    String labelText,
    String errorText,
    EdgeInsets contentPadding,
  }) {
    return InputDecoration(
      // hasFloatingPlaceholder: true,
      labelText: labelText,
      errorText: errorText,
      alignLabelWithHint: true,
      contentPadding: contentPadding,
      focusedBorder: createInputBorder(activeColor),
      errorBorder: createInputBorder(inactiveErrorColor),
      focusedErrorBorder: createInputBorder(activeErrorColor),
      border: createInputBorder(inactiveColor),
      disabledBorder: createInputBorder(inactiveColor),
      enabledBorder: createInputBorder(inactiveColor),
      labelStyle: createTextFieldLabelStyle(context),
      helperStyle: createTextFieldLabelStyle(context),
      hintStyle: createTextFieldLabelStyle(context),
    );
  }

  InputBorder createInputBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
      ),
    );
  }

  TextStyle createTextFieldLabelStyle(BuildContext context) {
    return TextStyle(
      color: labelColor,
      fontSize: 20,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w300,
    );
  }
}
