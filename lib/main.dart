import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:notify/NoteApp/HiveNotes.dart';
import 'package:notify/NoteApp/cube/cubit/note_cubit.dart';
import 'package:notify/NoteApp/myApp.dart';
import 'package:notify/NoteApp/note.dart';
// import 'package:schedule_local_notification/notificationservice.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'newNotify/notificationService.dart';

DateTime scheduleTime = DateTime.now();

int time = 0;
int id = 0;
void main() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.BoxName);
  await Hive.openBox("box2");

  // to ensure all the widgets are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // to initialize the notificationservice.
  NotificationService().initNotification();
  runApp(const MyApp());
}
