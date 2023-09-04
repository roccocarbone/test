import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/services/profile/update_profile.dart';
import 'package:student_link/views/signin/create_profile_page.dart';
import 'package:student_link/widgets/alert_dialog/bottom_alert.dart';

class CreateCarrierPage extends StatefulWidget {
  final String email;

  CreateCarrierPage(this.email, {Key? key}) : super(key: key);

  @override
  _CreateCarrierPageState createState() => _CreateCarrierPageState();
}

class _CreateCarrierPageState extends State<CreateCarrierPage> {
  String? selectedUniversity;
  String? selectedCourse;
  bool loadButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        'La tua carriera',
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
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _buildStyledDropdown(
                    value: selectedUniversity,
                    items: const [
                      DropdownMenuItem(child: Text("Liuc"), value: "Liuc"),
                    ],
                    onChanged: (value) =>
                        setState(() => selectedUniversity = value),
                    labelText: 'Università',
                    hintText: 'Quale università stai frequentando?',
                  ),
                  const SizedBox(height: 16),
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
                    onChanged: (value) =>
                        setState(() => selectedCourse = value),
                    labelText: 'Corso di studi',
                    hintText: 'Quale percorso di studi hai scelto?',
                  ),
                ],
              ),
            ),
          ),
          _buildContinueButton(),
        ],
      ),
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

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: _handleContinuePress,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(14.0),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
      ),
      child: loadButton
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Center(
              child: Text(
                'Continua',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Future<void> _handleContinuePress() async {
    setState(() => loadButton = true);

    if (selectedUniversity == null || selectedCourse == null) {
      setState(() => loadButton = false);
      _showDialogError('Ops..',
          'Ti sei dimenticato di inserire qualche dato. Prova a controllare...');
      return;
    }

    Map<String, dynamic> profileData = {
      'university': selectedUniversity,
      'courseOfStudy': selectedCourse,
    };

    try {
      await UpdateProfile.updateProfile(profileData, context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateProfilePage(widget.email)));
      setState(() => loadButton = false);
    } catch (error) {
      setState(() => loadButton = false);
      _showDialogError('Ops..', error.toString());
    }
  }

  void _showDialogError(String title, String message) {
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
