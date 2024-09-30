import 'package:flutter/material.dart';

class ConfirmationFieldLabel extends StatelessWidget {

  final IconData icon;
  final String text;

  const ConfirmationFieldLabel({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 10.0,
            ),
            Icon(
              icon,
              color: Color(0xFF333333),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF777777),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0,)
      ],
    );
  }
}
