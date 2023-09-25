import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/notes/get_my_notes/get_my_notes.dart';
import 'package:student_link/services/notes/get_preview_note/get_preview_note.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/services/profile/profile_me/profile_me.dart';
import 'package:student_link/views/bottom_nav/cerca/notes_list/note_page_detail/note_page_detail.dart';
import 'package:student_link/widgets/note/note_box_style/note_box_style.dart';

class ProfilePageUser extends StatefulWidget {
  final User user;
  const ProfilePageUser(this.user, {super.key});

  @override
  State<ProfilePageUser> createState() => _ProfilePageUserState();
}

class _ProfilePageUserState extends State<ProfilePageUser> {
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
              Navigator.pop(context, false);
            },
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                FutureBuilder<String?>(
                  future: GetProfilePhoto.fetchProfilePhoto(widget.user.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        padding: const EdgeInsets.all(1),
                        width: 75,
                        height: 75,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        padding: const EdgeInsets.all(1),
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return Container(
                        padding: const EdgeInsets.all(1),
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.file(
                            File(snapshot.data!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(1),
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.user.name} ${widget.user.surname}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '@${widget.user.username}',
                                  style: GoogleFonts.poppins(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: SvgPicture.asset(
                                'assets/icons/social/instagram.svg',
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              child: SvgPicture.asset(
                                  'assets/icons/social/facebook.svg',
                                  height: 26,
                                  width: 26,
                                  fit: BoxFit.scaleDown),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (widget.user.isVisible!) ...[
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Color(0xFFCDF0FF),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  'assets/icons/profile/position.svg',
                                  color: Theme.of(context).primaryColor,
                                  height: 16,
                                  width: 16,
                                  fit: BoxFit.scaleDown),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                          if (widget.user.services.carSharing) ...[
                            Container(
                              width: 30,
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Color(0xFFCDF0FF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.0),
                                ),
                              ),
                              child: SvgPicture.asset(
                                  'assets/icons/profile/car.svg',
                                  color: Theme.of(context).primaryColor,
                                  height: 16,
                                  width: 16,
                                  fit: BoxFit.scaleDown),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                          if (widget.user.services.tutoring) ...[
                            Container(
                              width: 30,
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                color: Color(0xFFCDF0FF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.0),
                                ),
                              ),
                              child: SvgPicture.asset(
                                  'assets/icons/profile/book.svg',
                                  color: Theme.of(context).primaryColor,
                                  height: 16,
                                  width: 16,
                                  fit: BoxFit.scaleDown),
                            ),
                          ],
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFFC6C6C6),
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/profile/cap.svg',
                                color: Theme.of(context).primaryColor,
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //TODO: SET NAME UNIVERSITY
                                  Text(
                                    widget.user.university,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  //TODO: SET TYPE UNIVERSITY
                                  Text(
                                    widget.user.courseOfStudy,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //TODO: SET
                      //DESCRIPTION USER
                      Text(
                        widget.user.bio,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Divider(
                        thickness: 1.5,
                        color: Color(0xFFC6C6C6),
                      ),
                      FutureBuilder<List<Note>>(
                        future: GetMyNote.getMyNotes(
                          context,
                          widget.user.id,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text("Errore: ${snapshot.error}");
                          } else {
                            List<Note> listaAppunti = snapshot.data!;

                            if (listaAppunti.isEmpty) {
                              return Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      width: 75,
                                      height: 75,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xffCDF0FF),
                                          width: 2,
                                        ),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icons/profile/note.svg',
                                        height: 15,
                                        width: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      'Ancora nessun appunto pubblicato',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xffCDF0FF),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: listaAppunti.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      //TODO: CLICK DA PARTE DI UN ALTRO UTENTE
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NotePageDetail(listaAppunti[index]),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF4F4F7),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: FutureBuilder(
                                                    future: GetPreviewNote
                                                        .fetchPreviewNote(
                                                      listaAppunti[index].id,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Container();
                                                      } else if (snapshot
                                                              .hasData &&
                                                          snapshot.data !=
                                                              null) {
                                                        return ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            8.0,
                                                          ),
                                                          child: Image.file(
                                                            File(
                                                                snapshot.data!),
                                                            fit: BoxFit.cover,
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                          ),
                                                        );
                                                      } else {
                                                        return Icon(
                                                          Icons
                                                              .sticky_note_2_outlined,
                                                          size: 40,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 8,
                                                  right: 8,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              117, 3, 168, 244),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    //TODO: SET TYPE OF NOTES
                                                    child: Text(
                                                      listaAppunti[index]
                                                          .noteType,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //TODO:
                                              //ICONA TIPO DI DOCUMENTO
                                              Image.asset(
                                                'assets/icons/immagini_provvisorie/pdf.png',
                                              ),
                                              //TODO: PASSARE NOME DOCUMENTO CARICATO.
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                    listaAppunti[index].title,
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
