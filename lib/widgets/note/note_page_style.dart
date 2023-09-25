import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/models/notes/request_note/request_note.dart';
import 'package:student_link/services/notes/get_preview_note/get_preview_note.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/widgets/containers/title_and_description.dart';

class NotePageStyle extends StatelessWidget {
  final Note note;
  const NotePageStyle(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                  ),
                  child: FutureBuilder(
                    future: GetProfilePhoto.fetchProfilePhoto(note.owner.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Container();
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return ClipOval(
                          child: Image.file(
                            File(snapshot.data!),
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return Icon(
                          Icons.person,
                          size: 40,
                          color: Theme.of(context).primaryColor,
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  note.owner.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '@${note.owner.username}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromARGB(134, 198, 198, 198),
            ),
            child: Row(
              children: [
                //TODO: ICON IN BASE AL TIPO DEL DOC
                const Icon(Icons.file_copy_outlined),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  note.title, //TODO CHIEDERE: CAPIRE QUESTIONE TIPO E NOME DOCUMENTO
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Anteprima',
            style: GoogleFonts.poppins(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            //TODO: PASSARE COPERTINA APPUNTO
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(134, 198, 198, 198),
              ),
            ),
            child: FutureBuilder(
              future: GetPreviewNote.fetchPreviewNote(
                note.id,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Container();
                } else if (snapshot.hasData && snapshot.data != null) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    child: Image.file(
                      File(snapshot.data!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  );
                } else {
                  return Icon(
                    Icons.sticky_note_2_outlined,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TitleAndDescription(
            'Titolo',
            note.title,
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          TitleAndDescription(
            'Descrizione',
            note.description,
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          TitleAndDescription(
            'Università',
            note.university,
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          TitleAndDescription(
            'Corso di studi',
            note.courseOfStudy,
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          TitleAndDescription(
            'Esame',
            note.exam ?? '',
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          TitleAndDescription(
            'Anno accademico',
            note.academicYear.toString(),
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          TitleAndDescription(
            'Tipologia',
            note.noteType,
          ),
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          TitleAndDescription(
            'Prezzo',
            '€ ${note.price.toString()}',
          ),
          const Divider(),
        ],
      ),
    );
  }
}
