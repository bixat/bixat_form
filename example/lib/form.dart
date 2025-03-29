import 'package:bixat_form/bixat_form.dart';
import 'package:flutter/material.dart';

const usernameKey = "username";
const passwordKey = "password";
const fullNameKey = "full_name";
const termsAcceptedKey = "terms_accepted";
const getUpdatesKey = "get_updates_accepted";

class MyForm with BixatForm {
  @override
  List<String> get optionalFields => [getUpdatesKey];

  // * Handle your data base on type
  @override
  BixatFormActions? typeToValue(Type type) {
    final result = switch (type) {
      const (ValueNotifier<bool>) => BixatFormActions<ValueNotifier<bool>>(
          get: (e) => e.value,
          validate: (e) => e.value,
          update: (key, e, newValue) => e.value = newValue,
          clear: (e, key) => e.value = false,
        ),
      const (TextEditingController) => BixatFormActions<TextEditingController>(
          get: (e) => e.text,
          validate: (e) => e.text.isNotEmpty,
          update: (key, e, value) => e.text = value,
          clear: (e, key) => e.clear(),
        ),
      _ => null,
    };
    return result;
  }
}
