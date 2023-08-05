import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/services/notes/get_my_notes/get_my_notes.dart';
import 'package:student_link/services/notes/get_preview_note/get_preview_note.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/services/profile/profile_me/profile_me.dart';
import 'package:student_link/views/bottom_nav/profilo/edit_profile/edit_profile_page.dart';
import 'package:student_link/views/bottom_nav/profilo/note/edit_note/edit_note_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:student_link/views/bottom_nav/profilo/note/publish_note/publish_note_page.dart';
import 'package:student_link/widgets/bottom_sheets/bottom_sheet_profile.dart';

class HomeProfile extends StatefulWidget {
  HomeProfile({super.key});

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: ProfileMe.getMyProfile(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Visualizza uno spinner di caricamento durante l'attesa
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Visualizza un messaggio di errore se si verifica un errore
            return const Center(
              child: Text(
                'Si è verificato un errore durante la richiesta',
              ),
            );
          } else if (snapshot.hasData) {
            User user = snapshot.data!;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    toolBarProfile(context, user),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: Column(children: [
                          descriptionUser(context, user),
                          buttonActionProfile(context, user),
                          userNotes(context, user),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          return Container(); // Placeholder widget
        },
      ),
    );
  }

  //WIDGET TOOLBAR, SEZIONE IN ALTO CON FOTO PROFILO ETC...
  Widget toolBarProfile(BuildContext context, User user) => Row(
        children: [
          FutureBuilder<String?>(
            future: GetProfilePhoto.fetchProfilePhoto(user.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); //TODO: CARICAMNETO IMMAGINE PROFILO
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.name} ${user.surname}',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '@${user.username}',
                          style: GoogleFonts.poppins(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.main_chat_page,
                            );
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/profile/chat.svg',
                            color: Theme.of(context).primaryColor,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(22),
                                  topRight: Radius.circular(22),
                                ),
                              ),
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) => const BottomSheetProfile(),
                            );
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/profile/menu.svg',
                            color: Theme.of(context).primaryColor,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child:
                          SvgPicture.asset('assets/icons/social/instagram.svg'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    //ICON FACEBOOK TRUE OR FALSE
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child:
                          SvgPicture.asset('assets/icons/social/facebook.svg'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFCDF0FF),
                        shape: BoxShape.circle,
                      ),
                      //TODO: EMAIL tutoraggio
                      child: const Icon(
                        Icons.mail,
                        size: 13,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    //ICON POSITION USER
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFCDF0FF),
                        shape: BoxShape.circle,
                      ),
                      //TODO: ICONA PSOITION USER
                      child: const Icon(
                        Icons.abc,
                        size: 13,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFCDF0FF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(3.0),
                        ),
                      ),
                      //TODO: ICONA CAR POOLING
                      child: const Icon(
                        Icons.abc,
                        size: 13,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    //ICON TUTORAGGIO TRUE OR FALSE
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFCDF0FF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(3.0),
                        ),
                      ),
                      //TODO: ICONA tutoraggio
                      child: const Icon(
                        Icons.abc,
                        size: 13,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );

  //SEZIONE DESCRIZIONE UTENTE. MOSTRARE DEFAULT SE VUOTA

  //TODO: CONTROLLO SE NON CI SONO INFO PASSARE SCHERMATA VUOTA
  Widget descriptionUser(BuildContext context, User user) => Column(
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
                        user.university,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      //TODO: SET TYPE UNIVERSITY
                      Text(
                        user.courseOfStudy,
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
            user.bio,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );

  //BOTTONI DI AZIONE PROFILO.
  Widget buttonActionProfile(BuildContext context, User user) => Center(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        user,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Modifica profilo',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  PlatformFile? file = await retrieveDoc();

                  if (file != null) {
                    final noteCreated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PublishNotePage(file),
                      ),
                    );

                    if (noteCreated) {
                      setState(() {}); 
                    }
                  }
                },
                child: Text(
                  'Pubblica',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Future<PlatformFile?> retrieveDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      return file;
    }
    return null;
  }

  bool isClicked = false;

  Widget userNotes(BuildContext context, User user) => Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          //TODO:
          /* Center(
            //TODO: INSERIRE TEXT FIELD RICERCA APPUNTI
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFc6c6c6),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8, right: 16),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cerca gli appunti',
                        helperStyle: GoogleFonts.poppins(
                          color: const Color(0XFFC6C6C6),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        // Update your state or perform actions based on the entered text
                      },
                      onTap: () {
                        setState(() {
                          isClicked = true;
                        });
                      },
                      onSubmitted: (value) {
                        setState(
                          () {
                            isClicked = false;
                          },
                        );
                      },
                    ),
                  ),
                  //TODO: COMPLETARE CLICK SU TEXTFIELD E CAMBIARE ICONE DI DESTRA e settare i clicck
                  isClicked
                      ? Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: IconButton(
                                onPressed: () {
                                  //TODO: FILTRI RICERCA APPUNTI DA VALUTARE, MAGARI FUTURO
                                },
                                icon: Icon(
                                  Icons.segment_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ), */
          const SizedBox(
            height: 8,
          ),
          const Divider(
            thickness: 1.5,
            color: Color(0xFFC6C6C6),
          ),
          FutureBuilder<List<Note>>(
            future: GetMyNote.getMyNotes(
              context,
              user.id,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
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
                          'Tutto cio che pubblicherai apparirà qui',
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
                          final editedNote = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditNotePage(
                                listaAppunti[index],
                              ),
                            ),
                          );

                          if(editedNote){
                            setState(() {
                            });
                          }
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(3),
                                      child: FutureBuilder(
                                        future: GetPreviewNote.fetchPreviewNote(
                                          listaAppunti[index].id,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Container();
                                          } else if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                            return Icon(
                                              Icons.sticky_note_2_outlined,
                                              size: 40,
                                              color: Theme.of(context)
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
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              117, 3, 168, 244),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        //TODO: SET TYPE OF NOTES
                                        child: Text(
                                          listaAppunti[index].noteType,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w600,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //TODO:
                                  //ICONA TIPO DI DOCUMENTO
                                  Image.asset(
                                    'assets/icons/immagini_provvisorie/pdf.png',
                                  ),
                                  //TODO: PASSARE NOME DOCUMENTO CARICATO.
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        listaAppunti[index].title,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w400,
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
      );
}
