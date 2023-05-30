import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wakeUpTimeProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay(hour: 6, minute: 20));