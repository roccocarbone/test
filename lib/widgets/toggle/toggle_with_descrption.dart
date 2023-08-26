import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ToggleWithDescription extends StatefulWidget {
  final String title, description;
  final bool isActive; // Aggiungi questa proprietà
  final ValueChanged<bool> onToggle;

  const ToggleWithDescription({
    required this.title,
    required this.description,
    required this.isActive, // Aggiungi questa linea
    required this.onToggle,
    Key? key,
  }) : super(key: key);

  @override
  State<ToggleWithDescription> createState() => _ToggleWithDescriptionState();
}

class _ToggleWithDescriptionState extends State<ToggleWithDescription> {
  bool _isActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isActive = widget.isActive;
  }

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
                widget.title,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              CupertinoSwitch(
                value: _isActive,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (bool value) {
                  setState(() {
                    _isActive = value;
                  });
                  widget.onToggle(value);
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          widget.description,
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
