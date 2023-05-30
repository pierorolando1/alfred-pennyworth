
import 'package:flutter/material.dart';

timeOfDayToDate(TimeOfDay tod) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
}