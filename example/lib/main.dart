import 'package:bixat_form/bixat_form.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

class LoginFormUI extends StatelessWidget {
  final bixatForm = BixatController();

  LoginFormUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Form')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: bixatForm.usernameField,
                    decoration: const InputDecoration(
                        labelText: 'Username', border: OutlineInputBorder()),
                    onChanged: bixatForm.onChanged,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: bixatForm.passwordField,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
                    onChanged: bixatForm.onChanged,
                  ),
                  const SizedBox(height: 16),
                  ListenableBuilder(
                    listenable: bixatForm.termsAcceptedField,
                    builder: (context, _) {
                      return CheckboxListTile(
                        title: const Text("Get updates (optional)"),
                        value: bixatForm.termsAcceptedField.value,
                        onChanged: (newValue) {
                          bixatForm.termsAcceptedField.value = newValue!;
                          bixatForm.onChanged(newValue);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder(
                    valueListenable: bixatForm.state,
                    builder: (context, _, __) {
                      return ElevatedButton(
                        onPressed: bixatForm.disabled ? null : bixatForm.submit,
                        child: Text(
                            bixatForm.state.value == BixatFormState.loading
                                ? 'Loading...'
                                : 'Login'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: LoginFormUI()));
