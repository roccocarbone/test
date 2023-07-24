import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_link/models/news/news.dart';
import 'package:student_link/services/news/get_news.dart';
import 'package:student_link/widgets/news/card/news_card.dart';
import 'package:student_link/views/bottom_nav/notizie/detail_news/page_details_news.dart';

class WordlNewsPage extends StatelessWidget {
  const WordlNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      future: NewsServices.getNews(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Errore durante il recupero delle notizie'));
        } else {
          List<NewsModel> newsList = snapshot.data ?? [];

          print(newsList);
          List<NewsModel> localNewsList =
              newsList.where((news) => news.category == 'WORLD').toList();

          if (localNewsList.isEmpty) {
            return const Center(child: Text('Nessuna notizia trovata.'));
          } else {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: localNewsList.map((news) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageNewsDetail(news),
                        ),
                      );
                    },
                    child: NewsCard(news),
                  );
                }).toList(),
              ),
            );
          }
        }
      },
    );
  }
}
