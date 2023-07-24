import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/models/news/news.dart';
import 'package:student_link/services/news/get_image_news/get_image_news.dart';

class NewsCard extends StatelessWidget {
  final NewsModel newsModel;
  const NewsCard(this.newsModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<ImageProvider>(
        future: NewsImageServices.getNewsImage(context, newsModel.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mostra un placeholder o indicatore di caricamento mentre attendiamo l'immagine
            return Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey[200],
              ),
              child: const Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.grey[200],
              ),
              child: const Center(
                  child: Text('Errore durante il recupero dell\'immagine')),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
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
                  height: 12,
                ),
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
                    //TODO: CAMBIA COLORE SE è un PREFERITO
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black12,
                      ),
                      child: const Icon(
                        Icons.star_border,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const Divider(),
              ],
            );
          }
        },
      ),
    );
  }
}
