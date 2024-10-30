import 'package:bixat_form/bixat_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const usernameKey = "username";
const passwordKey = "password";
const termsAcceptedKey = "terms_accepted";

class MyForm with BixatForm {
  TextEditingController get usernameField =>
      put(usernameKey, TextEditingController());
  TextEditingController get passwordField =>
      put(passwordKey, TextEditingController());
  ValueNotifier<bool> get termsAcceptedField =>
      put(termsAcceptedKey, ValueNotifier(false));

  @override
  List<String> get optionalFields => [termsAcceptedKey];

  @override
  bool onValidate(dynamic e) {
    if (e == null) return false;
    final bool result = switch (e.runtimeType) {
      const (TextEditingController) => e.text.isNotEmpty,
      const (ValueNotifier<bool>) => e.value,
      _ => true,
    };
    return result;
  }

  @override
  MapEntry<String, dynamic> getData(String key, value) {
    final result = switch (value.runtimeType) {
      const (TextEditingController) => value.text,
      const (ValueNotifier<bool>) => value.value,
      _ => value,
    };
    return MapEntry(key, result);
  }
}
