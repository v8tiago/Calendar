import 'package:flutter/material.dart';

class PopupDetails extends StatelessWidget {
  final String type;
  final String value;

  const PopupDetails({super.key, required this.type, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: type, style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: value),
        ],
      ),
    );
  }
}