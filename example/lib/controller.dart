import 'dart:developer';

import 'package:bixat_form/bixat_form.dart';
import 'package:example/form.dart';
import 'package:flutter/material.dart';

class BixatController extends MyForm {
  TextEditingController get usernameField =>
      put(usernameKey, TextEditingController());
  TextEditingController get fullNameField =>
      put(fullNameKey, TextEditingController());
  TextEditingController get passwordField =>
      put(passwordKey, TextEditingController());
  ValueNotifier<bool> get termsAcceptedField =>
      put(termsAcceptedKey, ValueNotifier(false));
  ValueNotifier<bool> get getUpdatesField =>
      put(getUpdatesKey, ValueNotifier(false));

  Future<void> submit() async {
    state.value = BixatFormState.loading;
    await Future.delayed(const Duration(seconds: 3));
    state.value = BixatFormState.done;
    log(data.toString());
    await Future.delayed(const Duration(seconds: 1));
    state.value = BixatFormState.enabled;
  }
}
