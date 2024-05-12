import 'package:flutter/material.dart';
import 'package:lifeline/shared/const_text_controllers.dart';
////////////////////////
/*
date picker constants
*/


Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2006),
    firstDate: DateTime(1900),
    lastDate: DateTime(2006),
  );
  return picked;
}

int day = 0;
int month = 0;
int year = 0;
Future showDatePickerFun(BuildContext context) async {
  final DateTime? picked = await selectDate(context);
  if (picked != null) {
    print('Selected date: $picked');
    day = picked.day;
    month = picked.month;
    year = picked.year;
    birthDayRegistration.text = picked.toString().split(' ')[0];
    print(picked.toString().split(' ')[0]);
  }
}