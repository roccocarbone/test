import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';

class PublishNotePage extends StatelessWidget {
  PublishNotePage({super.key});

  final TextEditingController _controllerTitolo = TextEditingController();
  final TextEditingController _controllerDescrizione = TextEditingController();
  final TextEditingController _controllerUniversita = TextEditingController();
  final TextEditingController _controllerCorso = TextEditingController();
  final TextEditingController _controllerEsame = TextEditingController();
  final TextEditingController _controllerAnnoAcc = TextEditingController();
  final TextEditingController _controllerTipologia = TextEditingController();
  final TextEditingController _controllerPrezzo = TextEditingController();

  //TODO: VERIFICARE SPAZIO DISPONIBILE PER INSERIRE DOCUMENTI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(68, 3, 168, 244),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(3),
              elevation: 0.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        title: Text(
          'Pubblica',
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(3),
                elevation: 0.0,
              ),
              onPressed: () {
                //TODO: SET POST Publish document  //TODO: VERIFICARE DATI INSERITI SE VUOTI ALERT DIALOG

                //MOSTRARE ALERT DIALOG E METTERE TUTTO PRONTO
              },
              child: const Icon(
                Icons.done_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO: PASSARE GRANDEZZA FILE
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Spazio utilizzato 1.8 GB / 5 GB',
                style: GoogleFonts.poppins(
                  color: Theme.of(context).primaryColor,
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                ),
              ),
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
            const SizedBox(
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
              //TODO: RENDERE CLICCABILE PER CARICAMNETO DI FILE
              height: 130,
              width: 130,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color.fromARGB(134, 198, 198, 198),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.photo_library_outlined,
                    color: Color.fromARGB(134, 198, 198, 198),
                    size: 40,
                  ),
                  Text(
                    'Carica anteprima',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color.fromARGB(134, 198, 198, 198),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            listTextField(),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: true,
                  onChanged: (newValue) {
                    //TODO: SET CHANGE VALUE
                  },
                ),
                Expanded(
                  child: Text(
                    "Dichiaro di essere l'autore del documento inserito e di rispettare le condizioni generali di StudentLINK.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listTextField() => Column(
        children: [
          StandardTextField(
            'Titolo del file',
            'Inserisci un titolo',
            _controllerTitolo,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            //TODO: CREATE EXPAND TEXTFIELD
            'Descrizione',
            'Inserisci una descrizione',
            _controllerDescrizione,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Università',
            "Seleziona un'universita",
            _controllerUniversita,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Corso di studi',
            'Selziona un corso di studi',
            _controllerCorso,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Esame',
            'Seleziona un esame',
            _controllerEsame,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Anno accademico',
            'Anno accademico di riferimento',
            _controllerAnnoAcc,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Tipologia',
            'Selziona una tipologia',
            _controllerTipologia,
          ),
          const SizedBox(
            height: 8,
          ),
          StandardTextField(
            'Prezzo di vendita',
            'Seleziona un prezzo di vendita',
            _controllerPrezzo,
          ),
        ],
      );
}
