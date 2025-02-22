import 'package:flutter/material.dart';

class CmTextField extends StatelessWidget {
  const CmTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        fillColor: Color.fromARGB(255, 245, 245, 245),
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
