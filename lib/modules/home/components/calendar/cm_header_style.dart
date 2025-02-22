import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CmHeaderStyle extends HeaderStyle {
  CmHeaderStyle({required BuildContext context})
      : super(
          formatButtonVisible: false,
          headerPadding: EdgeInsets.only(bottom: 10),
          titleTextStyle: TextStyle(
            fontSize: 20,
          ),
          titleCentered: true,
          titleTextFormatter: (date, locale) {
            String formattedDate = DateFormat.MMMM(locale).format(date);
            return formattedDate.replaceFirst(
              formattedDate[0],
              formattedDate[0].toUpperCase(),
            );
          },
        );
}
