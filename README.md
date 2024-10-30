Certainly! Here's a comprehensive README for the BixatForm package:

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

Here's a basic example of how to use BixatForm:

```dart
import 'package:bixat_form/bixat_form.dart';
import 'package:flutter/material.dart';

class MyForm with BixatForm {
  TextEditingController get usernameField =>
      put('username', TextEditingController());
  
  TextEditingController get passwordField =>
      put('password', TextEditingController());

  @override
  List<String> get optionalFields => ['terms_accepted'];

  @override
  bool onValidate(dynamic e) {
    if (e == null) return false;
    final bool result = switch (e.runtimeType) {
      TextEditingController => e.text.isNotEmpty,
      _ => true,
    };
    return result;
  }
}

class LoginFormUI extends StatelessWidget {
  final bixatForm = BixatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Form')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: bixatForm.usernameField,
              decoration: InputDecoration(labelText: 'Username'),
              onChanged: bixatForm.onChanged,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: bixatForm.passwordField,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              onChanged: bixatForm.onChanged,
            ),
            SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: bixatForm.state,
              builder: (context, _, __) {
                return ElevatedButton(
                  onPressed: bixatForm.disabled ? null : bixatForm.submit,
                  child: Text(bixatForm.state.value == BixatFormState.loading
                      ? 'Loading...'
                      : 'Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## Customization

### Optional Fields

Define optional fields that don't affect overall form validity:

```dart
class MyForm with BixatForm {
  @override
  List<String> get optionalFields => ['terms_accepted'];
}
```

### Validation Logic

Implement custom validation logic for each field:

```dart
@override
bool onValidate(dynamic e) {
  if (e == null) return false;
  final bool result = switch (e.runtimeType) {
    TextEditingController => e.text.isNotEmpty,
    _ => true,
  };
  return result;
}
```

### Data Retrieval

Get form data as needed through a unified API:

```dart
MapEntry<String, dynamic> getData(String key, value) {
  final result = switch (value.runtimeType) {
    TextEditingController => value.text,
    _ => value,
  };
  return MapEntry(key, result);
}
```

## State Management

BixatForm manages three states:

1. **Enabled**: Form is valid and ready for submission.
2. **Loading**: Form is submitting data.
3. **Disabled**: Form is invalid or disabled.
4. **Done**: Submission completed successfully.

You can access the current state using:

```dart
final currentState = bixatForm.state.value;
```

## Submit Functionality

Example of the submit function to handle form submission:

```dart
Future<void> submit() async {
  state.value = BixatFormState.loading;
  await Future.delayed(const Duration(seconds: 3));
  state.value = BixatFormState.done;
  log(data.toString());
  await Future.delayed(const Duration(seconds: 1));
  state.value = BixatFormState.enabled;
}
```

## Conclusion

BixatForm simplifies form management in Flutter applications by providing a reactive, stateful, and customizable solution. It handles validation, state transitions, and data retrieval, allowing developers to focus on building intuitive and efficient forms.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

