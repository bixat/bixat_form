import 'dart:developer';

import 'package:bixat_form/bixat_form.dart';
import 'package:example/form.dart';

class BixatController extends MyForm {
  Future<void> submit() async {
    state.value = BixatFormState.loading;
    await Future.delayed(const Duration(seconds: 3));
    state.value = BixatFormState.done;
    log(data.toString());
    await Future.delayed(const Duration(seconds: 1));
    state.value = BixatFormState.enabled;
  }
}
