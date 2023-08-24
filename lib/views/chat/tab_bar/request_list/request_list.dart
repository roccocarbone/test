import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/notes/request_note/request_note.dart';
import 'package:student_link/services/notes/request_note/get_request_note/get_my_request_note.dart';
import 'package:student_link/services/notes/request_note/received_request_note/received_request_note.dart';
import 'package:student_link/views/chat/tab_bar/request_list/box_request_style/box_request_style.dart';

class RequestList extends StatelessWidget {
  RequestList({super.key});

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade400,
              ),
            ),
            child: Text(
              "Accetta o rifiuta le richieste delle persone che desiderano scaricare i tuoi appunti.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          FutureBuilder<List<RequestNote>>(
            future: ReceivedRequestNote.myReceivedRequestNote(
              context,
              page,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<RequestNote>? requestNotes = snapshot.data;
                if (requestNotes == null || requestNotes.isEmpty) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFCDF0FF),
                          ),
                        ),
                        child: const Icon(
                          Icons.send_outlined,
                          color: Color(0xFFCDF0FF), //TODO: CAMBIARE ICONA SEND
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Nessuna richiesta ricevuta',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFCDF0FF),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: requestNotes.map((requestNote) {
                      return BoxRequestStyle(
                        requestNote,
                      );
                    }).toList(),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
