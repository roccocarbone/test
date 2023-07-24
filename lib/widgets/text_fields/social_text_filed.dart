import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialTextField extends StatelessWidget {
  final String hint;
  final String icon;
  final TextEditingController controller;
  const SocialTextField(this.hint, this.icon, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Center(
          child: SvgPicture.asset(
            'assets/icons/social/$icon.svg',
            height: 30,
            width: 30,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  color: const Color(0xFFC6C6C6),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
