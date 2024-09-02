import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_api/cards/students_card.dart';
import 'package:student_api/components/my_bottom_dialog.dart';
import 'package:student_api/components/my_card_loading_indicator.dart';
import 'package:student_api/models/students.dart';
import 'package:student_api/screens/student_info_page.dart';
import 'package:student_api/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Students> students = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      students = await ApiServices.fetchStudents();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      log('Error: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load students. Please try again later.';
      });
    }
  }

  Future<void> refresh() async {
    await fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: refresh,
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
            isLoading
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return const MyCardLoadingIndicator();
                      },
                      childCount: 6,
                    ),
                  )
                : errorMessage != null
                    ? SliverFillRemaining(
                        child: Center(
                          child: Text(
                            errorMessage!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                color: Colors.red,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final student = students[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentInfoPage(
                                            student: student,
                                          )));
                              log('Card selected ID is: ${student.id}');
                            },
                            child: StudentsCard(
                                firstName: student.firstName,
                                lastname: student.lastName,
                                course: student.course,
                                year: student.year,
                                enrolled: student.enrolled),
                          );
                        }, childCount: students.length),
                      ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const MyBottomDialog();
              });
        },
        backgroundColor: const Color(0xFFFCFCFC),
        shape: const CircleBorder(),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
