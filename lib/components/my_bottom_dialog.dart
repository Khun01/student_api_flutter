import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_api/components/my_text_field.dart';
import 'package:student_api/models/students.dart';
import 'package:student_api/screens/home_page.dart';
import 'package:student_api/services/api_services.dart';

class MyBottomDialog extends StatefulWidget {
  const MyBottomDialog({super.key});

  @override
  State<MyBottomDialog> createState() => _MyBottomDialogState();
}

class _MyBottomDialogState extends State<MyBottomDialog> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final courseController = TextEditingController();

  String dropdownText = 'First Year';
  bool isEnrolled = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> addStudents() async {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final course = courseController.text;

    final students = Students(
      firstName: firstName,
      lastName: lastName,
      course: course,
      year: dropdownText,
      enrolled: isEnrolled,
    );

    setState(() {
      isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 3));
      await ApiServices.addStudents(students);
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } catch (e) {
      log('Failed to add student: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextField(
            controller: firstNameController,
            labelText: 'First Name',
            icon: const Icon(Icons.person),
          ),
          const SizedBox(height: 16),
          MyTextField(
            controller: lastNameController,
            labelText: 'Last Name',
            icon: const Icon(Icons.person),
          ),
          const SizedBox(height: 16),
          MyTextField(
            controller: courseController,
            labelText: 'Course',
            icon: const Icon(Icons.school),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: const Color(0xFF3B3B3B))),
            child: DropdownButton(
              value: dropdownText,
              icon: const Icon(Icons.arrow_drop_down_circle_rounded),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownText = newValue!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'First Year',
                  child: Text('First Year'),
                ),
                DropdownMenuItem(
                  value: 'Second Year',
                  child: Text('Second Year'),
                ),
                DropdownMenuItem(
                  value: 'Third Year',
                  child: Text('Third Year'),
                ),
                DropdownMenuItem(
                  value: 'Forth Year',
                  child: Text('Forth Year'),
                ),
                DropdownMenuItem(
                  value: 'Fifth Year',
                  child: Text('Fifth Year'),
                )
              ],
              style: GoogleFonts.nunito(
                  color: const Color(0xFF3B3B3B), fontSize: 16),
              underline: Container(
                height: 0,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Switch(
                value: isEnrolled,
                onChanged: (value) {
                  setState(() {
                    isEnrolled = value;
                  });
                  log('Switch value is: $isEnrolled');
                },
                activeColor: Colors.blue,
                inactiveTrackColor: Colors.grey,
              ),
              Text(
                'Enrolled',
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: isEnrolled ? FontWeight.bold : null,
                    color: isEnrolled ? Colors.blue : const Color(0xFF3B3B3B)),
              ),
            ],
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      addStudents();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B3B3B)),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFCFCFC)),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
