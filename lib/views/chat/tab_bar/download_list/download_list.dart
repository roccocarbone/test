import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/notes/request_note/request_note.dart';
import 'package:student_link/services/notes/request_note/get_request_note/get_my_request_note.dart';
import 'package:student_link/views/chat/tab_bar/download_list/box_download_style/box_download_style.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key});

  //TODO: SE NON CI SONO APPUNTI DA SCARICARE MOSTRARE PAGE VUOTA

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
              'Qui trovi tutte le richieste di appunti che hai inviato',
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
            future: GetRequestNote.myRequestNote(context, 0),//TODO: PASARE LA GIUSTA PAGE
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
                        'Nessuna richiesta inviata',
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
                      return BoxDownloadStyle(
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
