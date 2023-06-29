import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/widgets/containers/title_and_description.dart';

class NotePageStyle extends StatelessWidget {
  const NotePageStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      size: 60, //TODO: INSERT PROFILE PHOTE UTENTE
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'NOME UTENTE', //TODO: SETTARE NOME AUTORE
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '@username',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromARGB(134, 198, 198, 198),
            ),
            child: Row(
              children: [
                //TODO: ICON IN BASE AL TIPO DEL DOC
                const Icon(Icons.file_copy_outlined),
                const SizedBox(
                  width: 8,
                ),
                //TODO: CAMBIARE CON NOME DOCUMENTO
                Text(
                  'Formulario termodinamica.pdf',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Anteprima',
            style: GoogleFonts.poppins(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            //TODO: PASSARE COPERTINA APPUNTO
            height: 130,
            width: 130,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(134, 198, 198, 198),
              ),
            ),
          ),
          //TODO: PASSARE I DATI DELLA NOTAA
          SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Titolo',
            'Formulario Termodinamica',
          ),

          Divider(),
          SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Descrizione',
            'Ma quande lingues coalesce, li grammatica del resultant lingue es plu simplic e regulari quam ti del coalescent lingues. Li nov lingua franca va esser plu simplic e regulari quam li existent Europan lingues. It',
          ),

          Divider(),
          SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Università',
            'LIUC Cattaneo',
          ),

          Divider(),
          SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Corso di studi',
            'Ingegneria gestionale',
          ),

          Divider(),
          SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Esame',
            'Servizi energetici',
          ),

          Divider(),
          SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Anno accademico',
            'Secondo',
          ),

          Divider(),
          SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Tipologia',
            'Appunti',
          ),

          Divider(),
          SizedBox(
            height: 8,
          ),

          TitleAndDescription(
            'Prezzo',
            '€ 4.99',
          ),

          Divider(),
        ],
      ),
    );
  }
}
