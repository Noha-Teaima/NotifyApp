import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  static String BoxName = "BoxName";
  static List<String> Notes = [];
  static List<String> Desc = [];
  static var box = Hive.box(BoxName);
  static var box2 = Hive.box("box2");

  static void addNote(String value, String desc) async {
    Notes.add(value);
    Desc.add(desc);
    print(Desc);
    print(Notes.toString() +
        "    olllllllllllllllllllllllllllllllllllllllllllllllllllllllll");

    await box.put("message", Notes);
    await box2.put("desc", Desc);
  }

  static Future<void> GetNotes() async {
    if (box.isNotEmpty) {
      await Future.delayed(Duration(seconds: 3)).then((value) {
        Notes = box.get("message");
        Desc = box2.get("desc");
      });
    }
  }

  static void removeItem(int index) async {
    Notes.removeAt(index);
    await box.put("message", Notes);
  }

  static void removeAll() async {
    Notes.clear();
    await box.put("message", Notes);
  }

  static void updateNotes(int index, String text, String desc) async {
    Notes[index] = text;
    Desc[index] = desc;
    await box.put("message", Notes);
  }
}
