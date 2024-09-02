import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentsCard extends StatelessWidget {
  final String firstName;
  final String lastname;
  final String course;
  final String year;
  final bool enrolled;
  const StudentsCard({
    super.key,
    required this.firstName,
    required this.lastname,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFFFCFCFC),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 2,
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFF3B3B3B),
            child: Icon(
              Icons.person,
              color: Color(0xFFFCFCFC),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        '$firstName $lastname',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                            fontSize: 16, color: const Color(0xFF3B3B3B)),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      enrolled ? 'Enrolled' : 'Not enrolled',
                      style: GoogleFonts.nunito(
                          fontSize: 12, color: const Color(0xFF3B3B3B)),
                    )
                  ],
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    course,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                        fontSize: 12, color: const Color(0xFF3B3B3B)),
                  ),
                ),
                Text(
                  year,
                  style: GoogleFonts.nunito(
                      fontSize: 12, color: const Color(0xFF3B3B3B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
