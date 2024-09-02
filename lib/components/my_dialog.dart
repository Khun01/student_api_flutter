import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_api/models/students.dart';
import 'package:student_api/screens/home_page.dart';
import 'package:student_api/services/api_services.dart';

class MyDialog extends StatefulWidget {
  final String selectedOption;
  final Students student;
  const MyDialog({super.key, required this.selectedOption, required this.student});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  
  bool isLoading = false;

  Future<void> deleteStudent() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Future.delayed(const Duration(seconds: 3));
      await ApiServices.deleteStudents(widget.student.id!);
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
      log('Deleted the student successfully');
    } catch (e) {
      log('Faile to delete students: $e');
    }
  }

  Future<void> upadateStudent() async{
    setState(() {
      isLoading = true;
    });
    try{
      await Future.delayed(const Duration(seconds: 3));
      await ApiServices.upadateStudents(widget.student.id!, widget.student);
      if (mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
      log('Student updated successfully');
    }catch(e){
      log('Failed to update student: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: const Color(0xFFFCFCFC),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.selectedOption == 'Update' ? 'Are you sure you want\nto update this?' : 'Are you sure you want\nto delete this?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3B3B3B)),
                ),
                const SizedBox(height: 24),
                isLoading ? const Center(child: CircularProgressIndicator()) : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 40),
                              side: const BorderSide(
                                color: Color(0xFF3B3B3B),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {
                              widget.selectedOption == 'Update' ? upadateStudent() : deleteStudent();
                            },
                            child: Text(
                              'Yes',
                              style: GoogleFonts.nunito(
                                  color: const Color(0xFF3B3B3B)),
                            )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3b3b3b),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 40)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'No',
                          style: GoogleFonts.nunito(
                              color: const Color(0xFFFCFCFC)),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
