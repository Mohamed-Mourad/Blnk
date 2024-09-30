import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboard;
  final FormFieldValidator<String?> validate;
  final String label;
  final Function(String?)? onSubmitted;
  final Function(String?)? onChanged;
  final VoidCallback? onTap;
  final bool isClickable;

  const DefaultFormField({
    super.key,
    required this.controller,
    required this.keyboard,
    required this.validate,
    required this.label,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
    this.isClickable = true,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClickable,
      validator: validate,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),

        label: Text(label),
      ),
    );
  }
}
