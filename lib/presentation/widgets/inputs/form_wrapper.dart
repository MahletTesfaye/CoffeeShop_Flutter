import 'package:flutter/material.dart';

class FormWrapper extends StatefulWidget {
  final List<Widget> inputFields;
  final VoidCallback onSubmit;
  final String submitTitle;
  final String? title;

  const FormWrapper({
    super.key,
    required this.inputFields,
    required this.onSubmit,
    required this.submitTitle,
    this.title,
  });

  @override
  State<FormWrapper> createState() => _FormWrapperState();
}

class _FormWrapperState extends State<FormWrapper> {
  final _formKey = GlobalKey<FormState>();
  String? generalError;
  bool isVisible = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            widget.title ?? "",
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ...widget.inputFields.map((field) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: field,
                    )),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(widget.submitTitle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
