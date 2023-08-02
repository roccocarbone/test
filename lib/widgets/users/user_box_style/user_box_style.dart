import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/widgets/alert_dialog/cards_marker/user/card_marker_user.dart';

class UserBoxStyle extends StatefulWidget {
  final User user;
  const UserBoxStyle(this.user, {super.key});

  @override
  State<UserBoxStyle> createState() => _UserBoxStyleState();
}

class _UserBoxStyleState extends State<UserBoxStyle> {
  //TODO: PASSARE UTENTE SINGOLO da cliccare
  void showMarkerDialogUser(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.zero,
        content: CardMarkerUser(user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO: APRIRE CARD UTENTE CON INFO

        showMarkerDialogUser(widget
            .user); //TODO: VERIFICARE QUI PER L'IMMAGINE SI POTREBBE PASSARE DIRETTAMNETE il pATH
      },
      child: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0
                      ),
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                    child: FutureBuilder(
                      future: GetProfilePhoto.fetchProfilePhoto(widget.user.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); //TODO: CARICAMNETO IMMAGINE PROFILO
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
                          '@${widget.user.username}',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).primaryColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.user.name + ' ' + widget.user.surname,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.user.university +
                              ' ' +
                              widget.user.courseOfStudy,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
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
        ),
      ),
    );
  }
}
