import 'package:flutter/material.dart';

class CmPopupDetails extends StatelessWidget {
  const CmPopupDetails({
    super.key,
    required this.type,
    required this.value,
  });
  final String type;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.all(5.0), // Adiciona um padding para melhor visualização
      child: Row(
        children: [
          Text(type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(width: 3.0),
          Expanded(child: Text(value, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
