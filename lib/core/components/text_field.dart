import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final double width;
  final TextEditingController controller;
  final String hintText;
  final EdgeInsets? padding;
  final bool? obsecureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const TextFieldComponent({
    super.key,
    this.padding,
    required this.width,
    required this.controller,
    required this.hintText,
    this.obsecureText,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: 0.7861 * width,
        child: TextFormField(
          controller: controller,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
          ),
          obscureText: obsecureText??false,
          onChanged: onChanged,
          validator: validator,
        ),
      ),
    );
  }
}
