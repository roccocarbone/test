import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/notes.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/views/bottom_nav/profilo/note/edit_note/edit_note_page.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              toolBarProfile(context),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    descriptionUser(context),
                    buttonActionProfile(context),
                    userNotes(context),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //WIDGET TOOLBAR, SEZIONE IN ALTO CON FOTO PROFILO ETC...
  Widget toolBarProfile(BuildContext context) => Row(
        children: [
          Container(
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
              //TODO: SOSTITUIRE CON IMMAGINE PROFILO
              child: Icon(
                Icons.person_2,
                size: 20,
              ),
            ),
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
                        //TODO: SETTARE NOME E COGNOME
                        Text(
                          'Alessia Rossi',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        //TODO: SETTARE USERNAME
                        Text(
                          '@rossialessia',
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
                        //TODO: SET BUTTON CHAT
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
                        //TODO: SET BUTTON MENù PROFILE
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(22),
                                  topRight: Radius.circular(22),
                                ),
                              ),
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) => BottomSheetProfile(),
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
                          color: Color(0xFFCDF0FF), shape: BoxShape.circle),
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
  Widget descriptionUser(BuildContext context) => Column(
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
                        'Insubria',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      //TODO: SET TYPE UNIVERSITY
                      Text(
                        'Economia e management',
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
            'Ma quande lingues coalesce, li grammatica del resultant lingue es plu simplic e regulari quam ti del coalescent lingues. Li nov lingua franca va esser plu simplic e regulari quam li existent Europan lingues. It va esser tam simplic quam Occidental: in fact, it va esser Occidental.',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );

  //BOTTONI DI AZIONE PROFILO.
  Widget buttonActionProfile(BuildContext context) => Center(
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
                  Navigator.pushNamed(
                    context,
                    RouteNames.edit_profile,
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
                onPressed: () {
                  //TODO: SET CLICK ON BUTTON
                  //TODO: APRIRE CONFIGURAZIONE DI SISTEMA PER CARICARE UN FILE
                  //SUCCESSIVAMENTE ANDARE ALLA PAGINA PER PUBBLICARE
                  Navigator.pushNamed(
                    context,
                    RouteNames.publish_note,
                  );
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

  List<Note> listaAppunti = [
    Note(
        id: '1',
        title: 'APPUNTO 1',
        description: 'POI SCRIVO',
        university: 'ciao',
        course: 'corso',
        exam: 'esame',
        year: '1000',
        type: 'pdf',
        pryce: 2,
        immagini: ['ciao', 'ciao']),
    Note(
        id: '2',
        title: 'APPUNTO 2',
        description: 'POI SCRIVO',
        university: 'ciao',
        course: 'corso',
        exam: 'esame',
        year: '1000',
        type: 'pdf',
        pryce: 2,
        immagini: ['ciao', 'ciao']),
    Note(
        id: '2',
        title: 'APPUNTO 2',
        description: 'POI SCRIVO',
        university: 'ciao',
        course: 'corso',
        exam: 'esame',
        year: '1000',
        type: 'pdf',
        pryce: 2,
        immagini: ['ciao', 'ciao']),
    Note(
        id: '2',
        title: 'APPUNTO 2',
        description: 'POI SCRIVO',
        university: 'ciao',
        course: 'corso',
        exam: 'esame',
        year: '1000',
        type: 'pdf',
        pryce: 2,
        immagini: ['ciao', 'ciao'])
  ];

  bool isClicked = false;

  Widget userNotes(BuildContext context) => Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Center(
            //TODO: INSERIRE TEXT FIELD RICERCA APPUNTI
            child: // Note: Same code is applied for the TextFormField as well
                Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFc6c6c6))),
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
                          color: Color(0XFFC6C6C6),
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
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(
            thickness: 1.5,
            color: Color(0xFFC6C6C6),
          ),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listaAppunti.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const EditNotePage(), //TODO: PASSARE L'APPUNTO
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
                                //INSERT IMAGE TODO
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(4),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(117, 3, 168, 244),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                //TODO: SET TYPE OF NOTES
                                child: Text(
                                  'Appunti',
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
                          Icon(Icons.file_copy_outlined),
                          //TODO: PASSARE NOME DOCUMENTO CARICATO.
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Formulario termodinamica',
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
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      );
}
