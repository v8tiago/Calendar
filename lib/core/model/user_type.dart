import 'package:flutter/material.dart';

enum UserType {
  master,
  basic,
}

extension UserTypeExtension on UserType {

  String get eventTypeDetail {
    switch (this) {
      case UserType.master:
        return 'MASTER';
      case UserType.basic:
        return 'BASIC'; 
      default:
        return '';
    }
  }
}