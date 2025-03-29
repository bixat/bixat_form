import '../bixat_form.dart';

class BixatFormActions<T> {
  final Function(T e) get;
  final bool? Function(T e) validate;
  final Function(String, T, dynamic) update;
  final Function(T, String) clear;

  BixatFormActions({
    required this.get,
    required this.validate,
    required this.update,
    required this.clear,
  });

  BixatFormActionType result<BixatFormActionType>(
      {required BixatFormAction action,
      String? key,
      required value,
      required newValue}) {
    return switch (action) {
      BixatFormAction.get => get(value),
      BixatFormAction.validate => validate(value),
      BixatFormAction.update => update(key!, value, newValue),
      BixatFormAction.clear => clear(value, key!),
    };
  }
}
