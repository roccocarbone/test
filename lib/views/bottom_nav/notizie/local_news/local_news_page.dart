import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/views/bottom_nav/notizie/detail_news/page_details_news.dart';
import 'package:student_link/widgets/news/card/news_card.dart';

class LocalNewsPage extends StatelessWidget {
  const LocalNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //TODO: METTERE DENTRO UN FUTUREBUILDER E PASSARE LA NEWS NELLA CARD
      child: Column(
        children: [
          //TODO: INSERIRE FILTRI SPECIFICI
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageNewsDetail(),
                ),
              );
            },
            child: NewsCard(),
          ), //PASSARE OGNI NEWS DENTRO LA CARD
          Divider(),
          InkWell(onTap: () { Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageNewsDetail(),
                ),
              );}, child: NewsCard()),
          Divider(),
          InkWell(onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageNewsDetail(),
                ),
              );
          }, child: NewsCard()),
        ],
      ),
    );
  }
}
