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
import 'package:notify/NoteApp/note.dart';
import 'package:notify/main.dart';
import 'package:notify/newNotify/notificationService.dart';
// import 'package:schedule_local_notification/notificationservice.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:hive/hive.dart';

DateTime scheduleTime = DateTime.now();

int time = 0;
int id = 0;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit()..getNotes(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notify',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

TextEditingController Notification_title = TextEditingController();
TextEditingController Notification_descrp = TextEditingController();

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(NoteApp());
              },
              icon: Icon(
                Icons.list,
                color: Colors.white,
                size: 40,
              ))
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Notify",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: Notification_title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Title",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: Notification_descrp,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Description",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  // NotificationService().showNotification(
                  //   1,
                  //   Notification_title.text,
                  //   Notification_descrp.text,
                  // );

                  if (Notification_title.text == '' ||
                      Notification_title.text == '') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              actions: [
                                FloatingActionButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Ok"),
                                )
                              ],
                              content: Text(
                                  "Please Enter Title Or Description For Your Note")

                              // content: Text("Please Enter The Correct Id"),
                              );
                        });
                  }
                  if (time == 0) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(actions: [
                            FloatingActionButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Ok"),
                            )
                          ], content: Text("Please Select Date & Time! ")

                              // content: Text("Please Enter The Correct Id"),
                              );
                        });
                  } else {
                    NotificationService().scheduleNotification(
                        id: id,
                        title: Notification_title.text,
                        body: Notification_descrp.text,
                        scheduledNotificationDateTime: scheduleTime);
                    cubit.addNotes(
                        Notification_title.text, Notification_descrp.text);
                    id++;

                    Get.to(NoteApp());
                    Notification_descrp.text = '';
                    Notification_title.text = '';
                    time = 0;
                  }
                },
                child: Container(
                  height: 40,
                  width: 200,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      "Add Notification",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                picker.DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (date) {
                    scheduleTime = date;
                    time = 1;
                  },
                  onConfirm: (date) {},
                );
              },
              child: const Text(
                'Select Date & Time',
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ),
      ),
    );
  }
}
