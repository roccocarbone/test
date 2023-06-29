import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/views/chat/tab_bar/chats_list/chats_list.dart';
import 'package:student_link/views/chat/tab_bar/download_list/download_list.dart';
import 'package:student_link/views/chat/tab_bar/request_list/request_list.dart';

class MainChat extends StatelessWidget {
  const MainChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Chat',
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        //ICONA PER TONRARE INDIETRO
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/app_bar/icon_back.svg',
            height: 30,
            width: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: DefaultTabController(
        length: 3,
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
                      Icons.people_alt_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.download_for_offline_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.info_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                ChatList(),
                DownloadList(),
                RequestList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
