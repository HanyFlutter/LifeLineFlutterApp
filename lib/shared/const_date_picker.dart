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
Future<DateTime?> selectDateBloodDrive(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
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
Future showDatePickerStart(BuildContext context) async {
  final DateTime? picked = await selectDateBloodDrive(context);
  if (picked != null) {
    print('Selected date: $picked');
    day = picked.day;
    month = picked.month;
    year = picked.year;
    bloodDriveStart.text = picked.toString().split(' ')[0];
    print(picked.toString().split(' ')[0]);
  }
}
Future showDatePickerStartArgent(BuildContext context) async {
  final DateTime? picked = await selectDateBloodDrive(context);
  if (picked != null) {
    print('Selected date: $picked');
    day = picked.day;
    month = picked.month;
    year = picked.year;
    argentCallStart.text = picked.toString().split(' ')[0];
    print(picked.toString().split(' ')[0]);
  }
}
Future showDatePickerEnd(BuildContext context) async {
  final DateTime? picked = await selectDateBloodDrive(context);
  if (picked != null) {
    print('Selected date: $picked');
    day = picked.day;
    month = picked.month;
    year = picked.year;
    bloodDriveEnd.text = picked.toString().split(' ')[0];
    print(picked.toString().split(' ')[0]);
  }
}