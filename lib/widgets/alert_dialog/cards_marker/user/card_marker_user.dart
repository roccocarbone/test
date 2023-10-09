import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:student_link/models/marker_info.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/profile/get_profile_photo/get_profile_photo.dart';
import 'package:student_link/views/profile_page/profile_page_user.dart';
import 'package:url_launcher/url_launcher.dart';

class CardMarkerUser extends StatefulWidget {
  final User user;
  const CardMarkerUser(this.user, {super.key});

  @override
  State<CardMarkerUser> createState() => _CardMarkerUserState();
}

class _CardMarkerUserState extends State<CardMarkerUser> {
  late PageController _pageController;

  String? _profileImagePath;

  bool _isImageLoading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _fetchProfilePhoto();
  }

  void _fetchProfilePhoto() async {
    String? profileImagePath =
        await GetProfilePhoto.fetchProfilePhoto(widget.user.id);

    setState(() {
      _profileImagePath = profileImagePath;
      _isImageLoading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: SETTARE I CLICK SULLE VARIE ICONE DELLA CARD

    //TODO: SEPARARE WIDGET DUE PAGINE

    return Stack(
      children: [
        SizedBox(
          height: 400,
          child: PageView(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10),
                  //TODO: CAMBIARE CON IMMAGINE PROFILO UTENTE image:
                  image: _profileImagePath != null
                      ? DecorationImage(
                          image: FileImage(
                            File(
                              _profileImagePath!,
                            ),
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _isImageLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      ) // <-- Mostra CircularProgressIndicator se l'immagine è in caricamento
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //TODO: LA CARD CAMBIA STILE SE è UTENTE O LOCALE
                            //NAME USER OR LOCAL
                            Text(
                              widget.user.name,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),

                            //USERNAME
                            Text(
                              '@${widget.user.username}',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            //TODO:
                            //PASSARE ICONA

                            //PASSARE DATI GIUSTI
                            Text(
                              widget.user.university,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),

                            Text(
                              widget.user.courseOfStudy,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
              ),
              //TODO: SECONDA PAGINA
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TODO
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(1),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProfilePageUser(widget.user),
                                  ),
                                );
                              },
                              child: ClipOval(
                                //TODO: SOSTITUIRE CON IMMAGINE PROFILO
                                child: _profileImagePath != null
                                    ? Image.file(
                                        File(_profileImagePath!),
                                        fit: BoxFit.cover,
                                      )
                                    : ClipOval(
                                        child: Icon(
                                          Icons.person,
                                          size: 16,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //TODO: INSERIRE NOME
                              Text(
                                widget.user.name,
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              //TODO: SETTARE USERNAME
                              Text(
                                '@${widget.user.username}',
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  //TODO:
                                  //ICON CAR POOLING TRUE OR FALSE
                                  widget.user.services.carSharing
                                      ? Container(
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              height: 16,
                                              width: 16,
                                              fit: BoxFit.scaleDown),
                                        )
                                      : Container(),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  //ICON TUTORAGGIO TRUE OR FALSE
                                  widget.user.services.tutoring
                                      ? Container(
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              height: 16,
                                              width: 16,
                                              fit: BoxFit.scaleDown),
                                        )
                                      : Container(),
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  //TODO:
                                  //ICON POSITION USER
                                  widget.user.isVisible!
                                      ? Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFCDF0FF),
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                              'assets/icons/profile/position.svg',
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              height: 16,
                                              width: 16,
                                              fit: BoxFit.scaleDown),
                                        )
                                      : Container(),
                                  /*  const SizedBox(
                                    width: 8,
                                  ),
                                  //ICON CHAT TRUE OR FALSE
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFCDF0FF),
                                      shape: BoxShape.circle,
                                    ),
                                    //TODO: ICONA CHAT
                                    child: const Icon(
                                      Icons.abc,
                                      size: 13,
                                    ),
                                  ), */
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (widget.user.social!.instagram != "" ||
                                          widget.user.social!.instagram ==
                                              null) {
                                        _launchInstagram(
                                            widget.user.social!.instagram ??
                                                "instagram");
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Nessun profilo instagram associato');
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icons/social/instagram.svg',
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  //ICON FACEBOOK TRUE OR FALSE
                                  InkWell(
                                    onTap: () {
                                      if (widget.user.social!.facebook != "" ||
                                          widget.user.social!.facebook ==
                                              null) {
                                        _launchFacebook(
                                            widget.user.social!.facebook ??
                                                "facebook");
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Nessun profilo facebook associato');
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icons/social/facebook.svg',
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      //DIVIDER
                      const Divider(
                        height: 1,
                        color: Color(0xFFC6C6C6),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //TODO SE DESCRIZIONE PRESENTE MOSTRARE TESTO SENNò IMMAGINE NESSUN TESTO

                      Text(
                        widget.user.bio,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: WormEffect(
                spacing: 5.0,
                radius: 5.0,
                dotHeight: 8.0,
                dotColor: const Color(0xFFD9D9D9),
                activeDotColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        )
      ],
    );
  }

  _launchInstagram(String usernameInsta) async {
    var webUrl = "https://www.instagram.com/$usernameInsta/";
    if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      print("can't open Instagram");
    }
  }

  _launchFacebook(String usernameFb) async {
    var nativeUrl = "fb://profile/$usernameFb";
    var webUrl = "https://www.facebook.com/$usernameFb";

    if (await canLaunch(nativeUrl)) {
      await launch(nativeUrl);
    } else if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      print("can't open Facebook");
    }
  }
}
