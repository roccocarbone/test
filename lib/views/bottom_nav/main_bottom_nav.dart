import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/views/bottom_nav/cerca/home_find.dart';
import 'package:student_link/views/bottom_nav/mappa/home_map.dart';
import 'package:student_link/views/bottom_nav/notizie/home_news.dart';
import 'package:student_link/views/bottom_nav/profilo/home_profile.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    const HomeNews(),
    const HomeFind(),
    const HomeMap(),
    HomeProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: const Color(0xFFC6C6C6),
        unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bottom_nav/news.svg',
              height: 24,
              width: 24,
              color: const Color(0xFFC6C6C6),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xFFCDF0FF)),
              child: SvgPicture.asset(
                'assets/icons/bottom_nav/news.svg',
                height: 24,
                width: 24,
                color: Theme.of(context).primaryColor,
              ),
            ),
            label: 'Notizie',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bottom_nav/find.svg',
              height: 24,
              width: 24,
              color: const Color(0xFFC6C6C6),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xFFCDF0FF)),
              child: SvgPicture.asset(
                'assets/icons/bottom_nav/find.svg',
                height: 24,
                width: 24,
                color: Theme.of(context).primaryColor,
              ),
            ),
            label: 'Cerca',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bottom_nav/maps.svg',
              height: 24,
              width: 24,
              color: const Color(0xFFC6C6C6),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xFFCDF0FF)),
              child: SvgPicture.asset(
                'assets/icons/bottom_nav/maps.svg',
                height: 24,
                width: 24,
                color: Theme.of(context).primaryColor,
              ),
            ),
            label: 'Mappa',
          ),

          //TODO: SETTARE RED DOT PER QUANDO C'è una notifica
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bottom_nav/profile.svg',
              height: 24,
              width: 24,
              color: const Color(0xFFC6C6C6),
            ),
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xFFCDF0FF)),
              child: SvgPicture.asset(
                'assets/icons/bottom_nav/profile.svg',
                height: 24,
                width: 24,
                color: Theme.of(context).primaryColor,
              ),
            ),
            label: 'Profilo',
          ),
        ],
      ),
    );
  }
}
