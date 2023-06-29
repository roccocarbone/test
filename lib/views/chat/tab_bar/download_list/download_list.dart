import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/views/chat/tab_bar/download_list/box_download_style/box_download_style.dart';

class DownloadList extends StatelessWidget {
  const DownloadList({super.key});

  //TODO: SE NON CI SONO APPUNTI DA SCARICARE MOSTRARE PAGE VUOTA

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.all(8),
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
          SizedBox(
            height: 8,
          ),
          BoxDownloadStyle(),
          BoxDownloadStyle(),
          BoxDownloadStyle(),
          BoxDownloadStyle(),
          BoxDownloadStyle(),
          BoxDownloadStyle(),
          BoxDownloadStyle(),
          BoxDownloadStyle(),
          BoxDownloadStyle(),
          BoxDownloadStyle(),
          BoxDownloadStyle(),
        ],
      ),
    );
  }
}
