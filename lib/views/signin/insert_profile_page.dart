import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_link/models/users/user.dart';
import 'package:student_link/services/profile/insert_profile_photo/insert_profile_photo.dart';
import 'package:student_link/services/profile/profile_me/profile_me.dart';
import 'package:student_link/views/signin/personal_services_page.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';

class InsertProfilePhotoPage extends StatefulWidget {
  final String email;

  const InsertProfilePhotoPage(this.email, {Key? key}) : super(key: key);

  @override
  State<InsertProfilePhotoPage> createState() => _InsertProfilePhotoPageState();
}

class _InsertProfilePhotoPageState extends State<InsertProfilePhotoPage> {
  File? _imageFile;
  bool loadUploadImage = false;

  @override
  void initState() {
    super.initState();
    // TODO: GET USER DATA
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Foto Profilo',
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Carica la foto che più ti rappresenta!',
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Center(
                      child: FutureBuilder<User>(
                        future: ProfileMe.getMyProfile(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return Text('No data found');
                          } else {
                            User userDetails = snapshot.data!;
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: _openImagePicker,
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: _imageFile == null
                                            ? const AssetImage(
                                                'assets/icons/immagini_provvisorie/camera.png')
                                            : FileImage(_imageFile!)
                                                as ImageProvider<Object>,
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '@${userDetails.username}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '${userDetails.name} ${userDetails.surname}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _imageFile == null ? _openImagePicker : _uploadImage,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(14.0),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
              ),
              child: loadUploadImage
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : Center(
                      child: Text(
                        _imageFile == null ? 'Aggiungi foto' : 'Carica foto',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
            if (_imageFile == null)
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PersonalServicesPage(widget.email),
                      ),
                    );
                  },
                  child: Text(
                    'Ricordamelo più tardi',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFA6A5A5),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _openImagePicker() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _imageFile = File(pickedImage.path);
        });
      }
    } catch (e) {
      print('Errore durante la selezione dell\'immagine: $e');
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null) {
      try {
        setState(() {
          loadUploadImage = true;
        });
        bool success = await uploadImage(_imageFile!);
        if (success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalServicesPage(widget.email),
            ),
          );
        } else {
          setState(() {
            loadUploadImage = false;
          });
          dialogError('Ops..', 'Errore durante il caricamento.');
        }
      } catch (error) {
        setState(() {
          loadUploadImage = false;
        });
        print('Error sending image to the server: $error');
      }
    } else {
      print('No image selected.');
    }
  }

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
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          child: BottomAlert(title, message),
        );
      },
    );
  }
}
