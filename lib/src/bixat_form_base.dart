import 'package:flutter/material.dart';

import 'bixat_form_actions.dart';

enum BixatFormState { enabled, loading, disabled, done }

mixin BixatForm {
  final Map<String, dynamic> _fields = {};
  final state = ValueNotifier(BixatFormState.disabled);
  bool get disabled => BixatFormState.disabled == state.value;

  T put<T>(String name, T value) {
    final result =
        _fields.putIfAbsent(name, () => value ?? TextEditingController());
    return result;
  }

  T set<T>(String name, {T? value}) {
    _fields[name] = value ?? TextEditingController();
    if (value != null) rebuild();
    return _fields[name];
  }

  T get<T>(String name) => _fields[name];

  void rebuild() {
    final isValid = _requiredFields.values.where(_validate).length ==
        _requiredFields.length;
    state.value = isValid ? BixatFormState.enabled : BixatFormState.disabled;
  }

  Map<String, dynamic> get _requiredFields => Map.from(_fields)
    ..removeWhere((key, value) => optionalFields.contains(key));

  T? handleTypes<T>(dynamic e,
      {BixatFormAction action = BixatFormAction.get, String? key, value}) {
    final formAction =
        typeToValue(e.runtimeType) ?? _typeToValue(e.runtimeType);
    return formAction.result<T>(
        action: action, key: key, value: e, newValue: value);
  }

  bool _validate(dynamic e) {
    if (e == null) return false;
    final isValid = handleTypes<bool?>(e, action: BixatFormAction.validate);
    return isValid ?? false;
  }

  void updateInstance<T>(String key, dynamic value) {
    final e = _fields[key];
    handleTypes(e, action: BixatFormAction.update, key: key, value: value);
  }

  MapEntry<String, dynamic> getData(String key, value) {
    final result = handleTypes(value, action: BixatFormAction.get);
    return MapEntry(key, result);
  }

  void setData(Map<String, dynamic> apiData) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for (var e in apiData.entries) {
        updateInstance(e.key, e.value);
        rebuild();
      }
    });
  }

  void clearData() {
    for (var e in _fields.entries) {
      final value = e.value;
      handleTypes(value, action: BixatFormAction.clear, key: e.key);
    }
    rebuild();
  }

  Map<String, dynamic> get data => _fields.map(getData)
    ..removeWhere((key, value) => excludeFields.contains(key));

  List<String> get optionalFields => [];
  List<String> get excludeFields => [];

  BixatFormActions<List> get listHandler => BixatFormActions<List>(
      get: (e) => e,
      validate: (e) => e.isNotEmpty,
      update: (key, e, value) => set(key, value: value),
      clear: (e, key) => e.clear());

  BixatFormActions? typeToValue(Type type) {
    return null;
  }

  BixatFormActions _typeToValue(Type type) => switch (type) {
        const (TextEditingController,) =>
          BixatFormActions<TextEditingController>(
            get: (e) => e.text,
            validate: (e) => e.text.isNotEmpty,
            update: (key, e, value) => e.text = value,
            clear: (e, key) => e.clear(),
          ),
        const (String,) => BixatFormActions<String>(
            get: (e) => e,
            validate: (e) => e.isNotEmpty,
            update: (key, e, value) => set(key, value: value),
            clear: (e, key) => set(key, value: null),
          ),
        const (int,) => BixatFormActions<int?>(
            get: (e) => e,
            validate: (e) => e != null,
            update: (key, e, value) => set(key, value: value),
            clear: (e, key) => set(key, value: null),
          ),
        const (bool,) => BixatFormActions<bool>(
            get: (e) => e,
            validate: (e) => e,
            update: (key, e, value) => set(key, value: value),
            clear: (e, key) => set(key, value: false),
          ),
        const (List,) ||
        const (List<bool>,) ||
        const (List<String>,) ||
        const (List<int>,) =>
          listHandler,
        _ => throw UnimplementedError(),
      };
}

enum BixatFormAction { get, validate, update, clear }
