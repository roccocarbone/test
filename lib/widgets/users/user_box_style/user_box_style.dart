import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class UserBoxStyle extends StatelessWidget {
  const UserBoxStyle({super.key});

  //TODO: PASSARE UTENTE SINGOLO da cliccare

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO: APRIRE CARD UTENTE CON INFO
      },
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '@lucaluca',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).primaryColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Luca Luca',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'LIUC Cattaneo - Ingegneria gestionale',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Divider(
                color: Colors.grey[300],
                height: 0,
                indent: 0,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
