import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_link/views/bottom_nav/notizie/local_news/local_news_page.dart';
import 'package:student_link/views/bottom_nav/notizie/world_news/world_news_page.dart';

class HomeNews extends StatelessWidget {
  const HomeNews({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
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
                tabs: const [
                  Tab(text: 'Notizie dal mondo'),
                  Tab(text: 'Notizie locali'),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                WordlNewsPage(),
                LocalNewsPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
