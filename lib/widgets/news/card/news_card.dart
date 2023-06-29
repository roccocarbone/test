import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.grey[200], //TODO: SOSTITUIRE CON IMMAGINE NEWS
            ),
          ),
          SizedBox(
            height: 12,
          ),
          //TODO: INSERIRE TESTI DELLA NEWS
          Text(
            'Il padre di chat GPT lancia l’allarme: “L’umanità rischia l’estinzione”',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              //TODO: INSERIRE AUTORE NEWS
              Text('Student link'),
              Text('-'),
              Spacer(),
              //TODO: CAMBIA COLORE SE è un PREFERITO
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black12,
                ),
                child: Icon(
                  Icons.star_border,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
