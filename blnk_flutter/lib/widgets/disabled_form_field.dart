import 'package:flutter/material.dart';

class DisabledFormField extends StatelessWidget {
  final String initialValue;
  final String label;

  const DisabledFormField({
    super.key,
    required this.initialValue,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.none,
      enabled: false,
      textAlignVertical: TextAlignVertical.center,
      minLines: 1,
      maxLines: 2,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,

      ),
      decoration: const InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Color(0xFFE2ECF7),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
      ),
    );
  }
}
