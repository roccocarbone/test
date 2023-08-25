import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/services/notes/request_note/send_request_note.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';
import 'package:student_link/widgets/note/note_page_style.dart';

class NotePageDetail extends StatelessWidget {
  final Note note;
  const NotePageDetail(this.note, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(68, 3, 168, 244),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(3),
              elevation: 0.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        title: Text(
          'Informazioni',
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(3),
                elevation: 0.0,
              ),
              onPressed: () {
                
                //TODO: APRIRE CHAT
              },
              child: Icon(
                Icons.chat,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NotePageStyle(note),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await SendRequestNote.sendRequestNote(
                      context,
                      note.id,
                    );
                    alertBottom(
                      'Ottimo',
                      'Richiesta inviata con successo',
                      context,
                    );
                  } catch (error) {
                    alertBottom(
                      'Ops..',
                      'Errore durante l\'invio della richiesta.',
                      context,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14.0),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text(
                  'Invia richiesta',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void alertBottom(String title, String message, BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: BottomAlert(
            title,
            message,
          ),
        );
      },
    );
  }
}
