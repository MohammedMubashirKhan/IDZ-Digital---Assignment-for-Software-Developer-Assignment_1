import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String name;
  final TextInputType textInputType;
  final TextEditingController controller;
  bool enable;
  String hint;
  TextInputField({
    Key? key,
    required this.name,
    required this.textInputType,
    required this.controller,
    required this.hint,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextField(
          controller: controller,
          enabled: enable,
          decoration:
              InputDecoration(border: const OutlineInputBorder(), hintText: hint
                  // hintText: "sadas",
                  ),
        ),
      ],
    );
  }
}
