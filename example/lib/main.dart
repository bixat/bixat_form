import 'package:bixat_form/bixat_form.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

class LoginFormUI extends StatefulWidget {
  const LoginFormUI({super.key});

  @override
  State<LoginFormUI> createState() => _LoginFormUIState();
}

class _LoginFormUIState extends State<LoginFormUI> {
  final bixatForm = BixatController();

  @override
  void initState() {
    bixatForm.setData({
      "username": "m97chahboun",
      "full_name": "Mohammed",
      "password": "@@@@@@@@@@",
      "get_updates_accepted": true,
      "terms_accepted": false
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Form')),
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
                    onChanged: (e) {
                      bixatForm.rebuild();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: bixatForm.fullNameField,
                    decoration: const InputDecoration(
                        labelText: 'Full name', border: OutlineInputBorder()),
                    onChanged: (e) {
                      bixatForm.rebuild();
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: bixatForm.passwordField,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password', border: OutlineInputBorder()),
                    onChanged: (e) {
                      bixatForm.rebuild();
                    },
                  ),
                  const SizedBox(height: 16),
                  ListenableBuilder(
                    listenable: bixatForm.getUpdatesField,
                    builder: (context, _) {
                      return CheckboxListTile(
                        title: const Text("Get updates (optional)"),
                        value: bixatForm.getUpdatesField.value,
                        onChanged: (newValue) {
                          bixatForm.getUpdatesField.value = newValue!;
                          bixatForm.rebuild();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ListenableBuilder(
                    listenable: bixatForm.termsAcceptedField,
                    builder: (context, _) {
                      return CheckboxListTile(
                        title: const Text("Accept terms"),
                        value: bixatForm.termsAcceptedField.value,
                        onChanged: (newValue) {
                          bixatForm.termsAcceptedField.value = newValue!;
                          bixatForm.rebuild();
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: bixatForm.clearData,
                          child: const Text("Clear fields")),
                      ValueListenableBuilder(
                        valueListenable: bixatForm.state,
                        builder: (context, _, __) {
                          return ElevatedButton(
                            onPressed:
                                bixatForm.disabled ? null : bixatForm.submit,
                            child: Text(
                                bixatForm.state.value == BixatFormState.loading
                                    ? 'Loading...'
                                    : 'Register'),
                          );
                        },
                      ),
                    ],
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
