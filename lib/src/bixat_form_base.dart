import 'package:flutter/material.dart';

enum BixatFormState { enabled, loading, disabled, done }

mixin BixatForm {
  final Map<String, dynamic> _fields = {};
  final state = ValueNotifier(BixatFormState.disabled);
  bool get disabled => BixatFormState.disabled == state.value;

  T put<T>(String name, T value) {
    final result = _fields.putIfAbsent(name, () => value);
    return result;
  }

  T set<T>(String name, value) {
    _fields[name] = value;
    if (value != null) onChanged(value);
    return _fields[name];
  }

  T get<T>(String name) => _fields[name];

  void onChanged(_) {
    final isValid = _requiredFields.values.where(onValidate).length ==
        _requiredFields.length;
    state.value = isValid ? BixatFormState.enabled : BixatFormState.disabled;
  }

  Map<String, dynamic> get _requiredFields => Map.from(_fields)
    ..removeWhere((key, value) => optionalFields.contains(key));

  bool onValidate(dynamic e);

  MapEntry<String, dynamic> getData(String key, value);

  Map<String, dynamic> get data => _fields.map(getData)
    ..removeWhere((key, value) => excludeFields.contains(key));

  List<String> get optionalFields => [];
  List<String> get excludeFields => [];
}
