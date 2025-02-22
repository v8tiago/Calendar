import 'package:flutter/material.dart';

class CmPopupDetails extends StatelessWidget {
  const CmPopupDetails({super.key, required this.type, required this.value});
  final String type;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14, color: Colors.black),
        children: <TextSpan>[
          TextSpan(text: type, style: TextStyle(fontWeight: FontWeight.w600)),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
