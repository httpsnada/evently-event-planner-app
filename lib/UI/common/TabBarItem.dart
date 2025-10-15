import 'package:evently/UI/design/design.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabBarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final int index;
  final int currentIndex;

  const TabBarItem({
    required this.icon,
    required this.text,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.white : Colors.transparent,
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(46),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: currentIndex == index ? AppColors.primary : Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: GoogleFonts.inter().fontFamily,
              color: currentIndex == index ? AppColors.primary : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
