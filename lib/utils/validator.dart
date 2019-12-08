import 'package:flutter/material.dart';
import 'package:flutter_app/utils/functional_interfaces.dart';
import 'package:meta/meta.dart';

abstract class Validator {
  final List<_Field> fields;

  Validator() : fields = [];

  Validator add<T, E>({
    @required T data,
    @required SingleFunction<T, E> onValidate,
    Consumer<T> onValid,
    Consumer<E> onInvalid,
  }) {
    fields.add(_Field<T, E>(
      data: data,
      onValidate: onValidate,
      onValid: onValid,
      onInvalid: onInvalid,
    ));
    return this;
  }

  bool validate() {
    bool isValid = true;
    for (_Field field in fields) {
      isValid &= field._validate();
    }
    return isValid;
  }
}

class _Field<T, E> {
  final T data;
  final SingleFunction<T, E> onValidate;
  final Consumer<T> onValid;
  final Consumer<E> onInvalid;

  _Field({
    @required this.data,
    @required this.onValidate,
    @required this.onValid,
    @required this.onInvalid,
  });

  bool _validate() {
    E error = onValidate(data);
    bool isValid = error == null;

    if (isValid && onValid != null) {
      onValid(data);
    }
    if (!isValid && onInvalid != null) {
      onInvalid(error);
    }

    return isValid;
  }
}
