import 'package:flutter/material.dart';

import 'package:student_link/services/notes/request_note.dart';
import 'package:student_link/widgets/note/note_box_style/note_box_style.dart';
import 'package:student_link/models/notes/note.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({Key? key}) : super(key: key);

  //TODO: INSERIRE PAGINAZIONE ALLA FINE DELLO SCROL

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>?>(
      future: RequestNote.getNotes('notes?page=0', context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Errore: ${snapshot.error}'),
          );
        } else {
          List<Note> notesData = snapshot.data!;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: notesData
                  .map(
                    (noteData) => NoteBoxStyle(noteData),
                  )
                  .toList(),
            ),
          );
        }
      },
    );
  }
}
