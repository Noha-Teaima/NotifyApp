import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cube/cubit/note_cubit.dart';

class testNote extends StatefulWidget {
  const testNote({super.key});

  @override
  State<testNote> createState() => _testNoteState();
}

class _testNoteState extends State<testNote> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();
    return Scaffold(
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is testNoteLoad) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 60,
                      margin: EdgeInsets.all(20),
                      child:
                          Center(child: Text(cubit.posts[index].title ?? "")),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: index % 2 == 0
                            ? Color.fromARGB(255, 193, 135, 230)
                            : const Color.fromARGB(255, 250, 60, 60),
                      ),
                    )),
          );
        },
      ),
    );
  }
}
