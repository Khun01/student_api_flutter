import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_api/bloc/show/show_student_bloc.dart';
import 'package:student_api/bloc/store/store_student_bloc.dart';
import 'package:student_api/components/my_text_field.dart';

class MyBottomDialog extends StatefulWidget {
  const MyBottomDialog({super.key});

  @override
  State<MyBottomDialog> createState() => _MyBottomDialogState();
}

class _MyBottomDialogState extends State<MyBottomDialog> {
  String dropdownText = 'First Year';
  bool isEnrolled = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreStudentBloc, StoreStudentState>(
      listener: (context, state) {
        if (state is StoreStudentFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
          log('The error is: ${state.error}');
        }else if(state is StoreStudentSuccess){
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Student Added Successfully')));
           Navigator.pop(context);
        }
      },
      builder: (context, state) {
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
                hintText: 'First Name',
                icon: const Icon(Icons.person),
                onChanged: (value) {
                  context
                      .read<StoreStudentBloc>()
                      .add(StoreStudentFirstName(firstName: value));
                },
              ),
              const SizedBox(height: 16),
              MyTextField(
                hintText: 'Last Name',
                icon: const Icon(Icons.person),
                onChanged: (value) {
                  context
                      .read<StoreStudentBloc>()
                      .add(StoreStudentLastName(lastName: value));
                },
              ),
              const SizedBox(height: 16),
              MyTextField(
                hintText: 'Course',
                icon: const Icon(Icons.school),
                onChanged: (value) {
                  context
                      .read<StoreStudentBloc>()
                      .add(StoreStudentCourse(course: value));
                },
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
                      context
                          .read<StoreStudentBloc>()
                          .add(StoreStudentYear(year: newValue));
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
                      value: 'Fourth Year',
                      child: Text('Fourth Year'),
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
                        context
                            .read<StoreStudentBloc>()
                            .add(StoreStudentEnrolled(enrolled: value));
                      });
                      log('Switch value is: ');
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
              state is StoreStudentLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<StoreStudentBloc>()
                              .add(StoreStudentButtonClicked(students: const [], showStudentBloc: context.read<ShowStudentBloc>()));
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
      },
    );
  }
}
