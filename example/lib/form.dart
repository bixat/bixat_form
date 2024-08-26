import 'dart:developer';

import 'package:bixat_form/bixat_form.dart';
import 'package:flutter/material.dart';

class MyForm with BixatForm {
  @override
  bool onValidate(e) {
    if (e == null) return false;
    final bool result = switch (e.runtimeType) {
      const (bool) => e,
      const (TextEditingController) => e.text.isNotEmpty,
      _ => e.isNotEmpty,
    };
    return result;
  }

  @override
  MapEntry<String, dynamic> getData(String key, value) {
    final result = switch (value.runtimeType) {
      const (TextEditingController) => value.text,
      _ => value
    };
    return MapEntry(key, result);
  }

  Future<void> submit() async {
    state.value = BixatFormState.loading;
    await Future.delayed(const Duration(seconds: 3));
    state.value = BixatFormState.done;
    log(data.toString());
  }
}
