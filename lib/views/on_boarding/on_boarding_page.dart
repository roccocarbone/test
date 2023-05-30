import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:student_link/routings/routes.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _pageController;

  bool islast = false;

  String textButton = 'Prossimo';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //TODO: VERIFICARE DI NON TORNARE INDIETRO ALLA CREAZIONE PROFILO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: demo_data.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnBoardingContent(
                  demo_data[index].image,
                  demo_data[index].title,
                  demo_data[index].description,
                ),
                onPageChanged: (index) {
                  if (index == 4) {
                    setState(() {
                      islast = true;
                      textButton = 'Cominciamo!';
                    });
                  } else {
                    setState(() {
                      islast = false;
                      textButton = 'Prossimo';
                    });
                  }
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 5,
              effect: ExpandingDotsEffect(
                  spacing: 5.0,
                  radius: 5.0,
                  dotHeight: 8.0,
                  dotColor: const Color(0xFFD9D9D9),
                  activeDotColor: Theme.of(context).primaryColor),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (islast) {
                          //TODO: SETTARE NON MOSTRARE Più ONBOARDING IN LOCAL STORAGE
                          Navigator.pushNamed(
                              context, RouteNames.main_bottom_nav);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(14.0),
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          textButton,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    !islast
                        ? Center(
                            child: TextButton(
                              onPressed: () {
                                //TODO: SETTARE NON MOSTRARE Più ONBOARDING IN LOCAL STORAGE
                                Navigator.pushNamed(
                                    context, RouteNames.main_bottom_nav);
                              },
                              child: Text(
                                'Salta',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFA6A5A5),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoard {
  final String image, title, description;

  OnBoard(
    this.image,
    this.title,
    this.description,
  );
}

final List<OnBoard> demo_data = [
  OnBoard(
    'assets/login/people_image.png',
    'Esplora la mappa',
    'Usa la mappa per conoscere nuovi studenti e per scoprire nuove offerte dai nostri negozi, bar e ristoranti partner!',
  ),
  OnBoard(
    'assets/login/people_image.png',
    'Rimani sempre informato',
    'Con la bacheca news, saprai subito in tempo reale quali sono ultime notizie dal mondo e nella tua zona!',
  ),
  OnBoard(
    'assets/login/people_image.png',
    'Scambia i tuoi appunti',
    'Metti in vendita a chiunque i tuoi appunti oppure acquista quelli di altri studenti.',
  ),
  OnBoard(
    'assets/login/people_image.png',
    'Scopri gli altri vantaggi',
    'Ci sono molte altre funzionalità disponibili come il tutoraggio, il car pooling e molto altro ancora!',
  ),
  OnBoard(
    'assets/login/people_image.png',
    'Cosa stai aspettando?',
    'Entra anche tu all’interno della community di Student Link, il primo Social Network universitario!',
  ),
];

class OnBoardingContent extends StatelessWidget {
  final String image, title, description;
  const OnBoardingContent(this.image, this.title, this.description,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset(
            image,
            width: 250,
            height: 400,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Theme.of(context).primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
