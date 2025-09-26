import 'package:evently/UI/design/design.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      "Evently",
      style: GoogleFonts.jockeyOne(
        fontSize: 36,
        // fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
