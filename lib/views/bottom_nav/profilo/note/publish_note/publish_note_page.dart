import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_link/models/notes/note.dart';
import 'package:student_link/services/notes/create_note/create_note.dart';
import 'package:student_link/services/notes/create_note/insert_document_note/insert_document_note.dart';
import 'package:student_link/services/notes/create_note/insert_preview_note/insert_preview_note.dart';
import 'package:student_link/services/notes/delete_note/delete_note.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';
import 'package:student_link/widgets/text_fields/standard_text_filed.dart';

class PublishNotePage extends StatefulWidget {
  final PlatformFile documentFile;
  PublishNotePage(this.documentFile, {super.key});

  @override
  State<PublishNotePage> createState() => _PublishNotePageState();
}

class _PublishNotePageState extends State<PublishNotePage> {
  final TextEditingController _controllerTitolo = TextEditingController();

  final TextEditingController _controllerDescrizione = TextEditingController();

  final TextEditingController _controllerUniversita = TextEditingController();

  final TextEditingController _controllerCorso = TextEditingController();

  final TextEditingController _controllerEsame = TextEditingController();

  final TextEditingController _controllerAnnoAcc = TextEditingController();

  final TextEditingController _controllerTipologia = TextEditingController();

  final TextEditingController _controllerPrezzo = TextEditingController();

  File? _imageFile;

  bool loadNote = false;

  String? selectedUniversity;
  String? selectedCourse;

  //TODO: VERIFICARE SPAZIO DISPONIBILE PER INSERIRE DOCUMENTI

  //TODO: INSERIRE CARICAMENTO DURANTE LA POST

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
              Navigator.pop(context, false);
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
                onPressed: () async {
                  //TODO: SET POST Publish document
                  //TODO: VERIFICARE DATI INSERITI SE VUOTI ALERT DIALOG

                  //TODO: CARICAMNETO NEL BUTTON

                  setState(() {
                    loadNote = true;
                  });

                  //TODO: MANCA UNIVERSITà
                  Map<String, dynamic> noteData = {
                    "title": _controllerTitolo.text,
                    "noteType": _controllerTipologia.text,
                    "university": selectedUniversity,
                    "courseOfStudy": selectedCourse,
                    "language": ["italiano"],
                    "description": _controllerDescrizione.text,
                    "price": int.tryParse(_controllerPrezzo.text) ?? 0,
                    "academicYear":
                        int.tryParse(_controllerAnnoAcc.text) ?? 0,
                  };

                  print(_controllerAnnoAcc.text);
                  print(_controllerPrezzo.text);

                  try {
                    Note notaCreata = await CreateNote.createNote(
                      noteData,
                      context,
                    );

                    try {
                      //ESEGUO POST FILE
                      await uploadDocumentNote(
                        widget.documentFile,
                        notaCreata.id,
                      );

                      // Esegu il caricamento dell'immagine di copertina
                      try {
                        //TODO: CREATE INSERT PREVIEW

                        if (_imageFile != null) {
                          await uploadPreviewtNote(
                            _imageFile!,
                            notaCreata.id,
                          );

                          setState(() {
                            loadNote = false;
                          });

                          Navigator.pop(context, true);
                        } else {
                          dialogError(
                            'Ops..',
                            'Inserisci anteprima',
                          );

                          setState(() {
                            loadNote = false;
                          });
                        }
                      } catch (error) {
                        //SE QUALCOSA NON VA A BUON FINE ELIMINO LA NOTA CREATA IN PRECEDENZA PER AVERE ID
                        await DeleteNote.deleteNote(
                          notaCreata.id,
                          context,
                        );

                        Navigator.pop(context);

                        dialogError(
                          'Ops..',
                          'Problemi con la pubblicazione, ripova!',
                        );

                        setState(() {
                          loadNote = false;
                        });
                      }

                      setState(() {
                        loadNote = false;
                      });
                    } catch (error) {
                      print(
                          'Errore durante l\'upload del file o dell\'immagine di copertina $error');

                      await DeleteNote.deleteNote(
                        notaCreata.id,
                        context,
                      );

                      setState(() {
                        loadNote = false;
                      });

                      dialogError(
                        'Ops..',
                        'Errore durante il caricamento, riprova!',
                      );

                      // Chiamare il metodo di eliminazione qui
                    }
                  } catch (error) {
                    setState(() {
                      loadNote = false;
                    });
                    print('Errore durante la creazione della nota $error');
                    dialogError(
                      'Ops..',
                      'Errore durante il caricamento, riprova!',
                    );
                  }
                },
                child: loadNote
                    ? Container(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.done_rounded,
                        color: Colors.white,
                      )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO: PASSARE GRANDEZZA FILE
            //TODO: FARE LA POST DEL FILE

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

                  Expanded(
                    child: Text(
                      widget.documentFile.name,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
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
            GestureDetector(
              onTap: () {
                _openImagePicker();
              },
              child: Container(
                height: 130,
                width: 130,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color.fromARGB(134, 198, 198, 198),
                  ),
                  image: DecorationImage(
                    image: _imageFile == null
                        ? const AssetImage(
                            'assets/icons/profile/insert_preview.png',
                          )
                        : FileImage(_imageFile!) as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            listTextField(),
            const SizedBox(
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
          _buildStyledDropdown(
            value: selectedUniversity,
            items: const [
              DropdownMenuItem(child: Text("Liuc"), value: "Liuc"),
            ],
            onChanged: (value) => setState(() => selectedUniversity = value),
            labelText: 'Università',
            hintText: 'Università',
          ),
          const SizedBox(
            height: 8,
          ),
          _buildStyledDropdown(
            value: selectedCourse,
            items: const [
              DropdownMenuItem(
                  value: "Ing. Gestionale - Triennale",
                  child: Text("Ing. Gestionale - Triennale")),
              DropdownMenuItem(
                  value: "Ing. Gestionale - Magistrale",
                  child: Text("Ing. Gestionale - Magistrale")),
              DropdownMenuItem(
                  value: "Eco. Aziendale - Triennale",
                  child: Text("Eco. Aziendale - Triennale")),
              DropdownMenuItem(
                  value: "Eco. Aziendale - Magistrale",
                  child: Text("Eco. Aziendale - Magistrale")),
            ],
            onChanged: (value) => setState(() => selectedCourse = value),
            labelText: 'Corso di studi',
            hintText: 'Corso di studi',
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

  Future<void> _openImagePicker() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  //ALERT DIALOG DI ERRORE PASSANDO TESTI
  void dialogError(String title, String message) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: BottomAlert(
            title,
            message,
          ),
        );
      },
    );
  }

  Widget _buildStyledDropdown({
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
    required String labelText,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: GoogleFonts.poppins(
            color: Theme.of(context).primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: value,
              items: items,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFFC6C6C6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
