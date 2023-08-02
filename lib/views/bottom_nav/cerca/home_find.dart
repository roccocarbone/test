import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/views/bottom_nav/cerca/notes_list/notes_list_page.dart';
import 'package:student_link/views/bottom_nav/cerca/users_list/users_list_page.dart';

class HomeFind extends StatelessWidget {
  const HomeFind({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //TODO: SEARCH BAR APPUNTI
            /* Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                  suffixIcon: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /* ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFCDF0FF),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(3),
                          elevation: 0.0,
                        ),
                        onPressed: () {
                          //TODO: SET DELETE TEXT
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(3),
                          elevation: 0.0,
                        ),
                        onPressed: () {
                          //TODO: SET DELETE TEXT
                        },
                        child: Icon(
                          Icons.segment_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                      ), */
                    ],
                  ),
                  hintText: ('Cerca gli appunti'),
                  hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFFC6C6C6),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.transparent, // Sfondo trasparent
                  enabledBorder: const OutlineInputBorder(
                    // Bordo quando si è concentrati
                    borderRadius: BorderRadius.all(
                      Radius.circular(14.0),
                    ), // Bordo arrotondato
                    borderSide: BorderSide(
                      color: Color(
                        0xFFC6C6C6,
                      ),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    // Bordo quando si è concentrati
                    borderRadius: BorderRadius.all(
                      Radius.circular(14.0),
                    ), // Bordo arrotondato
                    borderSide: BorderSide(
                      color: Color(
                        0xFFC6C6C6,
                      ),
                    ),
                  ),
                ),
              ),
            ), */
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scaffold(
                    appBar: AppBar(
                      toolbarHeight: 0,
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      bottom: TabBar(
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: const Color(0xffCDF0FF),
                        tabs: [
                          Tab(
                            icon: Icon(
                              Icons.book,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.people_outline_sharp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: const TabBarView(
                      children: [
                        NotesListPage(),
                        UsersListPage(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
