import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  final controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
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
      ),
    );
  }
}
