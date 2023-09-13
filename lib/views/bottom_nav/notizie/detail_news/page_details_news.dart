import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/news/news.dart';
import 'package:student_link/services/news/get_image_news/get_image_news.dart';

class PageNewsDetail extends StatelessWidget {
  final NewsModel newsModel;
  const PageNewsDetail(this.newsModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(3),
              elevation: 0.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(3),
                elevation: 0.0,
              ),
              onPressed: () {
                // TODO: ADD TO FAVORITE
              },
              child: Icon(
                Icons.star_border,
                color: Colors.lightBlue.shade100,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<ImageProvider>(
        future: NewsImageServices.getNewsImage(context, newsModel.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading image."));
          } else {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.7,
                  minChildSize: 0.7,
                  maxChildSize: 1,
                  builder: (context, scrollController) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        controller: scrollController, // Add this
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    newsModel.author.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xffA6A5A5),
                                    ),
                                  ),
                                  //  const Text('Student link'), TODO: INSEIRE DATA CREAZIONE
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                newsModel.title,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                newsModel.body,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Divider(),
                              Text(
                                'Pubblicato da',
                                style: GoogleFonts.poppins(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  //TODO: SEGNALARE MANCANZA ICONA AUTORE
                                  /* Container(
                              height: 60,
                              width: 60,
                            ), */
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsModel.author.name,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        newsModel.author.description,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Divider()
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
