import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import "package:flutter/material.dart";

const String calendar2022 =
    '[["31","25","31","29","31","30","29","31","30","31","30","23"],["18","14","18","14","18","17","18","18","19","18","17","12"],["19","15","21","18","19","20","19","19","20","19","18","13"],["20","16","22","19","20","21","20","22","21","20","21","14"],["21","17","23","20","23","22","21","23","22","21","22","15"],["24","18","24","22","24","23","22","24","23","24","23","16"],["25","21","25","25","25","24","25","25","26","25","24","19"],["26","22","28","26","26","27","26","26","27","26","25","20"],["27","23","29","27","27","28","27","29","28","27","28","21"],["28","24","30","28","30","29","28","30","29","28","29","22"]]';
const String calendar2023 =
    '[["31","28","31","28","31","30","31","31","29","31","30","22"],["18","13","20","14","18","19","18","18","18","18","17","11"],["19","14","21","17","19","20","19","21","19","19","20","12"],["20","15","22","18","22","21","20","22","20","20","21","13"],["23","16","23","19","23","22","21","23","21","23","22","14"],["24","17","24","20","24","23","24","24","22","24","23","15"],["25","22","27","24","25","26","25","25","25","25","24","18"],["26","23","28","25","26","27","26","28","26","26","27","19"],["27","24","29","26","29","28","27","29","27","27","28","20"],["30","27","30","27","30","29","28","30","28","30","29","21"]]';
const String calendar2023Update =
    '[["31","28","31","28","31","30","31","31","29","31","30","22"],["18","13","20","14","18","19","18","18","18","18","17","11"],["19","14","21","17","19","20","19","21","19","19","20","12"],["20","15","22","18","22","21","20","22","20","20","21","13"],["23","16","23","19","23","22","21","23","21","23","22","14"],["24","17","24","20","24","23","24","24","22","24","23","15"],["25","22","27","24","25","26","25","25","25","25","24","18"],["26","23","28","25","26","27","26","28","26","26","27","19"],["27","24","29","26","29","28","27","29","27","27","28","20"],["30","27","30","27","30","29","28","30","28","30","29","21"]]';

class CalendarController {
  static final CalendarController _instance = CalendarController._();

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  factory CalendarController() => _instance;

  CalendarController._();
  BuildContext get context => key.currentState!.context;

  DateTime getCurrentDay(List<DateTime> days) {
    final now = DateTime.now();
    for (var day in days) {
      if (now.month == day.month) {
        if (now.day <= day.day) {
          return day;
        } else {
          int index = days.indexOf(day);
          if (index + 1 == days.length) {
            return day;
          } else {
            return days[index + 1];
          }
        }
      }
    }
    return now;
  }

  List<DateTime> getDaysInYear(int nis) {
    late dynamic calendar;
    try {
      final remoteConfigAdConfigValue =
          FirebaseRemoteConfig.instance.getString('payment_calendar_nis');
      calendar = jsonDecode(remoteConfigAdConfigValue);
    } catch (e) {
      calendar = jsonDecode(calendar2023Update);
    }
    final calendarByNis = calendar[nis];
    List<DateTime> days = [];
    for (var i = 0; i < calendarByNis.length; i++) {
      int day = int.parse(calendarByNis[i]);
      int month = i + 1;
      int year = 2023;
      days.add(DateTime(year, month, day));
    }
    return days;
  }
}
