import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../HiveNotes.dart';
import '../../model/notesModel.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());
  int updateIndex = -1;
  void getNotes() async {
    emit(NoteLoading());
    await HiveHelper.GetNotes();
    emit(NoteSuccess());
  }

  void addNotes(String text) {
    HiveHelper.addNote(text);
    emit(NoteSuccess());
  }

  void removeItem(int index) {
    HiveHelper.removeItem(index);
    emit(NoteSuccess());
  }

  void removeAll() {
    HiveHelper.removeAll();
    emit(NoteSuccess());
  }

  void updateItem(int index, String text) {
    emit(NoteLoadingItem());

    HiveHelper.updateNotes(index, text);
    emit(NoteSuccess());
  }

  List<notesModel> posts = [];

  void getPosts() async {
    emit(testNoteLoad());
    var response =
        await Dio().get("https://jsonplaceholder.typicode.com/posts");
    // print(response);
    List json = response.data;

    posts = json.map((e) => notesModel.fromJson(e)).toList();
    // print(posts);
    emit(testNoteSuccess());
  }

  List<Map> users = [];
  void postData({required String email, required String password}) async {
    emit(testNoteLoad());
    var response = await Dio().post( "https://student.valuxapps.com/api/login",
        data: {"email": email, "password": password});
    // List json = response.data;

    print(response.data.toString() + "hhhhhhhhhhhhhhhhhhhh");
    emit(testNoteSuccess());
  }
}
