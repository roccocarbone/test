import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/notes/request_note/request_note.dart';
import 'package:student_link/services/notes/request_note.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';

class BoxDownloadStyle extends StatefulWidget {
  final RequestNote requestNote;
  const BoxDownloadStyle(this.requestNote, {super.key});

  @override
  State<BoxDownloadStyle> createState() => _BoxDownloadStyleState();
}

class _BoxDownloadStyleState extends State<BoxDownloadStyle> {
  Color colorHex = Color(0xFFE5B300);

  @override
  void initState() {
    super.initState();

    if (widget.requestNote.status == 'ACCEPTED') {
      colorHex = Color(0xFF1CC40D);
    } else if (widget.requestNote.status == 'REJECT') {
      colorHex = Color(0xFFFF0000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorHex,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: FutureBuilder(
                  future: GetProfilePhoto.fetchProfilePhoto(
                      widget.requestNote.note.owner.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(color: colorHex,);
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
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.requestNote.note.owner.name} ${widget.requestNote.note.owner.surname}',
                      style: GoogleFonts.poppins(
                        color: colorHex,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
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
                            widget.requestNote.note.title, //TODO: insert .type
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),

                          widget.requestNote.note.downloadable
                              ? IconButton(
                                  onPressed: () {
                                    //TODO: SETTARE DOWNLOAD NOTA
                                  },
                                  icon: const Icon(
                                    Icons.download_rounded,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //TODO: INSERIRE DATA ULTIMO MESSAGGIO
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Divider(
            color: Colors.grey[300],
            height: 0,
            indent: 0,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
