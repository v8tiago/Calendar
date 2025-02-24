import 'package:flutter/material.dart';

class CmButton extends StatelessWidget {
  const CmButton({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(Color.fromARGB(255, 11, 137, 123)),
      ),
      child: const Center(
        child: Text(
          "Entrar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
