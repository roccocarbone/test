import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/notes/request_note/request_note.dart';
import 'package:student_link/services/notes/get_preview_note/get_preview_note.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/widgets/containers/title_and_description.dart';

class RequestPageNote extends StatelessWidget {
  final RequestNote requestNote;
  const RequestPageNote(this.requestNote, {super.key});

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
                    future: GetProfilePhoto.fetchProfilePhoto(
                        requestNote.note.owner.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Container();
                      } else if (snapshot.hasData &&
                          snapshot.data != null &&
                          requestNote.note.owner.id != '') {
                        return ClipOval(
                          child: Image.file(
                            File(snapshot.data!),
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${requestNote.claimer.name} ${requestNote.claimer.surname}',
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
                  '@${requestNote.claimer.username}',
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
                  requestNote.note.title, //TODO: passare tipo documento
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
                requestNote.note.id,
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
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    child: Icon(
                      Icons.sticky_note_2_outlined,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }
              },
            ),
          ),
          //TODO: PASSARE I DATI DELLA NOTAA
          const SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Titolo',
            requestNote.note.title,
          ),

          const Divider(),
          const SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Descrizione',
            requestNote.note.description,
          ),

          const Divider(),
          const SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Università',
            requestNote.note.university,
          ),

          const Divider(),
          const SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Corso di studi',
            requestNote.note.courseOfStudy,
          ),

          const Divider(),
          const SizedBox(
            height: 8,
          ),

          const TitleAndDescription(
            'Esame',
            'Servizi energetici', //TODO CHIEDERE: NOME ESAME
          ),

          const Divider(),
          const SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Anno accademico', //TODO CHIEDERE
            requestNote.note.academicYear.toString(),
          ),

          const Divider(),
          const SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Tipologia',
            requestNote.note.noteType,
          ),

          const Divider(),
          const SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Prezzo',
            '€ ${requestNote.note.price.toString()}',
          ),

          const Divider(),
        ],
      ),
    );
  }
}
