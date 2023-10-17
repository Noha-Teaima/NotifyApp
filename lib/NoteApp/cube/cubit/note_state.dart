part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoading extends NoteState {}

final class NoteSuccess extends NoteState {}

final class NoteLoadingItem extends NoteState {}

final class testNoteLoad extends NoteState {}

final class testNoteSuccess extends NoteState {}
