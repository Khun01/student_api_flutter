import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_api/bloc/show/show_student_bloc.dart';
import 'package:student_api/bloc/store/store_student_bloc.dart';
import 'package:student_api/cards/students_card.dart';
import 'package:student_api/components/my_bottom_dialog.dart';
import 'package:student_api/components/my_card_loading_indicator.dart';
import 'package:student_api/screens/student_info_page.dart';
import 'package:student_api/services/api_services.dart';
import 'package:student_api/services/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ShowStudentBloc showStudentBloc =
        ShowStudentBloc(apiServices: ApiServices(apiurl: baseUrl))
          ..add(FetchStudents());
    final StoreStudentBloc storeStudentBloc =
        StoreStudentBloc(apiServices: ApiServices(apiurl: baseUrl));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => showStudentBloc,
        ),
        BlocProvider(
          create: (context) => storeStudentBloc,
        ),
      ],
      child: BlocConsumer<ShowStudentBloc, ShowStudentState>(
        listener: (context, state) {
          if (state is ShowStudentFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
            log('The error is: //${state.error}');
          }else if (state is ShowStudentSuccess){
             
          }
        },
        builder: (context, state) {
          Widget body;
          if (state is ShowStudentFailed) {
            body = SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'Failed to load, please try again later',
                  style: GoogleFonts.nunito(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            );
          } else if (state is ShowStudentLoading) {
            body = SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const MyCardLoadingIndicator();
                },
                childCount: state.student.length,
              ),
            );
          } else if (state is ShowStudentSuccess) {
            if (state.student.isEmpty) {
              body = SliverToBoxAdapter(
                child: SizedBox(
                  height: 166,
                  child: Center(
                    child: Text(
                      'Coming soon!',
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3B3B3B)),
                    ),
                  ),
                ),
              );
            } else {
              final reversedList = state.student.reversed.toList();
              body = SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final student = reversedList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StudentInfoPage(student: student)));
                    },
                    child: StudentsCard(
                        firstName: student.firstName,
                        lastname: student.lastName,
                        course: student.course,
                        year: student.year,
                        enrolled: student.enrolled),
                  );
                }, childCount: reversedList.length),
              );
            }
          } else {
            body = SliverToBoxAdapter(
                child: Center(
              child: Text(
                'Network Error!',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3B3B3B)),
              ),
            ));
          }
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.only(top: 16, left: 20),
                      child: Text(
                        'List of Students',
                        style: GoogleFonts.nunito(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3B3B3B)),
                      ),
                    ),
                  ),
                  body,
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16,),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: storeStudentBloc,
                          ),
                          BlocProvider.value(
                            value: showStudentBloc,
                          ),
                        ],
                        child: const MyBottomDialog(),
                      );
                    });
              },
              backgroundColor: const Color(0xFFFCFCFC),
              shape: const CircleBorder(),
              child: const Icon(Icons.person_add),
            ),
          );
        },
      ),
    );
  }
}
