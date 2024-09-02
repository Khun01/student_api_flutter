import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_api/components/my_dialog.dart';
import 'package:student_api/components/my_text_field.dart';
import 'package:student_api/models/students.dart';

class StudentInfoPage extends StatefulWidget {
  final Students student;
  const StudentInfoPage({super.key, required this.student});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final courseController = TextEditingController();
  late String year;
  late bool isEnrolled;
  @override
  void initState(){
    super.initState();
    year = widget.student.year;
    isEnrolled = widget.student.enrolled;
  }

  bool isLoading = false;

  String selectedOption = '';

  void showTheDialog() {
    final updatedStudent = Students(
      id: widget.student.id,
      firstName: firstNameController.text.isNotEmpty ? firstNameController.text : widget.student.firstName,
      lastName: lastNameController.text.isNotEmpty ? lastNameController.text : widget.student.lastName,
      course: courseController.text.isNotEmpty ? courseController.text : widget.student.course,
      year: year.isNotEmpty ? year : widget.student.year, 
      enrolled: isEnrolled ? isEnrolled : widget.student.enrolled,
    );

    showDialog(
      context: context,
      builder: (context) => MyDialog(
        selectedOption: selectedOption,
        student: updatedStudent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Color(0xFF3B3B3B),
                child: Icon(
                  Icons.person,
                  size: 100,
                  color: Color(0xFFFCFCFC),
                ),
              ),
            ),
            const SizedBox(height: 16),
            MyTextField(
                controller: firstNameController,
                labelText: widget.student.firstName,
                icon: const Icon(Icons.person)),
            const SizedBox(height: 16),
            MyTextField(
                controller: lastNameController,
                labelText: widget.student.lastName,
                icon: const Icon(Icons.person)),
            const SizedBox(height: 16),
            MyTextField(
                controller: courseController,
                labelText: widget.student.course,
                icon: const Icon(Icons.person)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: const Color(0xFF3B3B3B))),
              child: DropdownButton(
                value: widget.student.year,
                icon: const Icon(Icons.arrow_drop_down_circle_rounded),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.student.year = newValue!;
                    year = widget.student.year;
                      log('The new year is: $year');
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
                  value: widget.student.enrolled,
                  onChanged: (value) {
                    setState(() {
                      widget.student.enrolled = value;
                      isEnrolled = widget.student.enrolled;
                      log('The new enrolled is: $isEnrolled');
                    });
                    log('Switch value is: ${widget.student.enrolled}');
                  },
                  activeColor: Colors.blue,
                  inactiveTrackColor: Colors.grey,
                ),
                Text(
                  'Enrolled',
                  style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight:
                          widget.student.enrolled ? FontWeight.bold : null,
                      color: widget.student.enrolled
                          ? Colors.blue
                          : const Color(0xFF3B3B3B)),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      selectedOption = 'Update';
                      showTheDialog();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B3B3B)),
                    child: Text(
                      'Update',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFCFCFC)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      selectedOption = 'Delete';
                      showTheDialog();
                    },
                    child: Text(
                      'Delete',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
