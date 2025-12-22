import 'package:flutter/material.dart';

class FormErrorText extends StatelessWidget {
  final String? error;

  const FormErrorText({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    if (error == null) return SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(error!, style: TextStyle(color: Colors.red, fontSize: 12)),
    );
  }
}
