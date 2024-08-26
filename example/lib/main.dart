import 'package:bixat_form/bixat_form.dart';
import 'package:example/form.dart';
import 'package:flutter/material.dart';

const fieldName = "field_name";
const checkboxName = "checkboxa_name";

class MyFormUI extends StatelessWidget {
  final bixatForm = MyForm();

  MyFormUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: bixatForm.put(fieldName, TextEditingController()),
              onChanged: bixatForm.onChanged,
            ),
            Checkbox(
              value: bixatForm.put(checkboxName, false),
              onChanged: bixatForm.onChanged,
            ),
            ValueListenableBuilder(
                valueListenable: bixatForm.state,
                builder: (context, _, __) {
                  return ElevatedButton(
                      onPressed: bixatForm.disabled ? null : bixatForm.submit,
                      child: switch (bixatForm.state.value) {
                        BixatFormState.disbaled => const Text("Disabled"),
                        BixatFormState.enabled => const Text("Submit"),
                        BixatFormState.done => const Text("Done"),
                        BixatFormState.loading =>
                          const CircularProgressIndicator(),
                      });
                }),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: MyFormUI()));
