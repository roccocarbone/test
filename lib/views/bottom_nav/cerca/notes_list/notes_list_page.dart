import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_link/widgets/note/note_box_style/note_box_style.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          NoteBoxStyle(),
          NoteBoxStyle(),
          NoteBoxStyle(),
          NoteBoxStyle(),
          NoteBoxStyle(),
          NoteBoxStyle(),
        ],
      ),
    );
  }
}
