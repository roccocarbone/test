import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ToggleWithDescription extends StatelessWidget {
  final String title, description;
  final bool active;
  const ToggleWithDescription(this.title, this.description, this.active,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFFF4F4F7),
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              CupertinoSwitch(
                value: true,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (bool active) {
                  //TODO:SET TOGGLE INPUT
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          description,
          style: GoogleFonts.poppins(
            color: Theme.of(context).primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
