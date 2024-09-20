import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_api/bloc/delete/delete_student_bloc.dart';
import 'package:student_api/bloc/update/update_student_bloc.dart';
import 'package:student_api/components/my_dialog.dart';
import 'package:student_api/components/my_text_field.dart';
import 'package:student_api/models/students.dart';
import 'package:student_api/screens/home_page.dart';
import 'package:student_api/services/api_services.dart';
import 'package:student_api/services/global.dart';

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
  void initState() {
    super.initState();
    year = widget.student.year;
    isEnrolled = widget.student.enrolled;
  }

  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    final UpdateStudentBloc updateStudentBloc =
        UpdateStudentBloc(apiServices: ApiServices(apiurl: baseUrl));
    final DeleteStudentBloc deleteStudentBloc =
        DeleteStudentBloc(apiServices: ApiServices(apiurl: baseUrl));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => updateStudentBloc,
        ),
        BlocProvider(
          create: (context) => deleteStudentBloc,
        ),
      ],
      child: BlocConsumer<UpdateStudentBloc, UpdateStudentState>(
        listener: (context, state) {
          if (state is UpdateStudentSuccess) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          } else if (state is UpdateStudentFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
            log('The error is:${state.error}');
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
                          hintText: widget.student.firstName,
                          icon: const Icon(Icons.person),
                          onChanged: (value) {
                            context
                                .read<UpdateStudentBloc>()
                                .add(UpdateStudentFirstName(firstName: value));
                          }),
                      const SizedBox(height: 16),
                      MyTextField(
                          hintText: widget.student.lastName,
                          icon: const Icon(Icons.person),
                          onChanged: (value) {
                            context
                                .read<UpdateStudentBloc>()
                                .add(UpdateStudentLastName(lastName: value));
                          }),
                      const SizedBox(height: 16),
                      MyTextField(
                          hintText: widget.student.course,
                          icon: const Icon(Icons.person),
                          onChanged: (value) {
                            context
                                .read<UpdateStudentBloc>()
                                .add(UpdateStudentCourse(course: value));
                          }),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: const Color(0xFF3B3B3B))),
                        child: DropdownButton(
                          value: year,
                          icon:
                              const Icon(Icons.arrow_drop_down_circle_rounded),
                          onChanged: (String? newValue) {
                            setState(() {
                              year = newValue!;
                              log('The new year is: //');
                            });
                            context
                                .read<UpdateStudentBloc>()
                                .add(UpdateStudentYear(year: year));
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
                              value: 'Fourth Year',
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
                                log('The new enrolled is: ');
                              });
                              context.read<UpdateStudentBloc>().add(
                                  UpdateStudentEnrolled(enrolled: isEnrolled));
                            },
                            activeColor: Colors.blue,
                            inactiveTrackColor: Colors.grey,
                          ),
                          Text(
                            'Enrolled',
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: isEnrolled ? FontWeight.bold : null,
                                color: isEnrolled
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
                                context.read<UpdateStudentBloc>().add(
                                    UpdateStudentButtonClickedEvent(
                                        students: widget.student));
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
                                // showTheDialog();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(
                                            value: updateStudentBloc,
                                          ),
                                          BlocProvider.value(
                                            value: deleteStudentBloc,
                                          ),
                                        ],
                                        child: MyDialog(
                                            selectedOption: selectedOption,
                                            student: widget.student),
                                      );
                                    });
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
                ),
                if (state is UpdateStudentLoading) ...[
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ]
              ],
            )),
          );
        },
      ),
    );
  }
}
