import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_link/routings/routes.dart';

class BottomSheetProfile extends StatelessWidget {
  const BottomSheetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TODO: COMPLETE WITH ICONS
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          height: 3,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        //TODO: COMPLETE AMBASSADOR LINEE

        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.notification_important_outlined,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Ambassador program',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
        //TODO: COMPLETE CAMBIA PASSWORD LINEE
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.change_password,
            );
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/profile/bottom_sheet_settings/lock.svg',
                  color: Colors.black,
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Cambia password',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
        //TODO: COMPLETE SUPPORTO LINEE
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/profile/bottom_sheet_settings/users.svg',
                  color: Colors.black,
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Supporto',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
        //TODO: COMPLETE FAQ LINEE
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/profile/bottom_sheet_settings/help-octagon.svg',
                  color: Colors.black,
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'FAQ',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
        //TODO: COMPLETE PRIVACY LINEE
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
               SvgPicture.asset(
                    'assets/icons/profile/bottom_sheet_settings/info-hexagon.svg',
                    color: Colors.black,
                    height: 24,
                    width: 24,
                  ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Privacy policy',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
        //TODO: COMPLETE DELETE ACCOUT LINEE
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.delete_account);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
               SvgPicture.asset(
                    'assets/icons/profile/bottom_sheet_settings/square-rounded-x.svg',
                    color: Colors.black,
                    height: 24,
                    width: 24,
                  ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Cancella account',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
        //TODO: COMPLETE LOG OUT LINEE
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.log_out);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                    'assets/icons/profile/bottom_sheet_settings/logout_prof.svg',
                    color: Colors.black,
                    height: 24,
                    width: 24,
                  ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Log out',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
