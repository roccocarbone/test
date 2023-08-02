import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/models/notes/request_note/request_note.dart';
import 'package:student_link/services/notes/request_note/accept_request/accept_request.dart';
import 'package:student_link/services/notes/request_note/reject_request/reject_request.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';
import 'package:student_link/widgets/note/note_page_request.dart';
import 'package:student_link/widgets/note/note_page_style.dart';

class SingleRequestPage extends StatelessWidget {
  final RequestNote requestNote;
  const SingleRequestPage(this.requestNote, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Richiesta',
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        //ICONA PER TONRARE INDIETRO
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/app_bar/icon_back.svg',
            height: 30,
            width: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RequestPageNote(requestNote),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: requestNote.status == 'PENDING'
                  ? Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              side: BorderSide(
                                width: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onPressed: () async {
                              try {
                                Map<String, dynamic> noteData = {
                                  "status": "REJECT",
                                  "expiresAt": "2023-07-26",
                                };

                                await RejectRequest.rejectRequest(
                                  noteData,
                                  requestNote.id,
                                  context,
                                );

                                dialogMessage(
                                  'Ottimo',
                                  'Hai rifiutato la richiesta.',
                                  context,
                                );
                              } catch (error) {
                                print(error);
                                dialogMessage(
                                  'Ops..',
                                  'Errore, riprova a rifiutare la richiesta.',
                                  context,
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Rifiuta',
                                style: GoogleFonts.poppins(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              elevation: 0.0,
                            ),
                            onPressed: () async {
                              

                              try {
                                Map<String, dynamic> noteData = {
                                  "status": "ACCEPTED",
                                  "expiresAt": "2023-07-26",
                                };

                                await AcceptRequest.acceptRequest(
                                  noteData,
                                  requestNote.id,
                                  context,
                                );

                                dialogMessage(
                                  'Ottimo',
                                  'Hai accettato la richiesta.',
                                  context,
                                );
                              } catch (error) {
                                print(error);
                                dialogMessage(
                                  'Ops..',
                                  'Errore, riprova ad accettare la richiesta.',
                                  context,
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Accetta',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  void dialogMessage(String title, String message, BuildContext context) {
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
