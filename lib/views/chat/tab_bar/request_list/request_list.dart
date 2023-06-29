import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/views/chat/tab_bar/request_list/box_request_style/box_request_style.dart';

class RequestList extends StatelessWidget {
  const RequestList({super.key});


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
              "Accetta o rifiuta le richieste delle persone che desiderano scaricare i tuoi appunti.",
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
          BoxRequestStyle(),
          BoxRequestStyle(),
          BoxRequestStyle(),
          BoxRequestStyle(),
          BoxRequestStyle(),
          BoxRequestStyle(),
          BoxRequestStyle(),
          BoxRequestStyle(),
          BoxRequestStyle(),

        ],
      ),
    );
  }
}
