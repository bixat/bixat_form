# BixatForm

BixatForm is a Flutter package designed to simplify form creation and management in Flutter applications. It provides a powerful and flexible solution for building reactive forms with built-in validation and state management.

## Features

- **Reactive Forms**: Create forms that automatically update based on user input and validation status.
- **Built-in Validation**: Implement custom validation logic for each form field.
- **State Management**: Easily manage form state transitions (enabled, loading, disabled, done).
- **Flexible Data Retrieval**: Get form data as needed through a unified API.
- **Optional Fields**: Support for optional fields that don't affect overall form validity.
- **Exclude Fields**: Ability to exclude certain fields from being included in the final data.

## Installation

Add BixatForm to your Flutter project:

```yaml
dependencies:
  bixat_form: ^<latest_version>
```

## Usage

check basic [example](./example/lib/main.dart) of how to use BixatForm


## Customization

### Optional Fields

Define optional fields that don't affect overall form validity:

```dart
@override
List<String> get optionalFields => ['terms_accepted'];
```

### Validation Logic

Implement custom handling logic for each field base on type:

```dart
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
```

### Data Retrieval

Get form data using:

```dart
final formData = bixatForm.data;
```

## State Management

BixatForm manages four states:

1. **Enabled**: Form is valid and ready for submission.
2. **Loading**: Form is submitting data.
3. **Disabled**: Form is invalid or disabled.
4. **Done**: Submission completed successfully.

Access the current state using:

```dart
final currentState = bixatForm.state.value;
```

## Submit Functionality

Example of handling form submission:

```dart
@override
Future<void> submit() async {
  state.value = BixatFormState.loading;
  await Future.delayed(const Duration(seconds: 3));
  state.value = BixatFormState.done;
  print(data);
  await Future.delayed(const Duration(seconds: 1));
  state.value = BixatFormState.enabled;
}
```

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
