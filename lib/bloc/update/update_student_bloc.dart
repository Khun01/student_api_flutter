import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_api/models/students.dart';
import 'package:student_api/services/api_services.dart';

part 'update_student_event.dart';
part 'update_student_state.dart';

class UpdateStudentBloc extends Bloc<UpdateStudentEvent, UpdateStudentState> {
  final ApiServices apiServices;
  UpdateStudentBloc({required this.apiServices})
      : super(UpdateStudentInitial()) {
    on<UpdateStudentButtonClickedEvent>(updateStudentButtonClickedEvent);
    on<UpdateStudentFirstName>(updateStudentFirstName);
    on<UpdateStudentLastName>(updateStudentLastName);
    on<UpdateStudentCourse>(updateStudentCourse);
    on<UpdateStudentYear>(updateStudentYear);
    on<UpdateStudentEnrolled>(updateStudentEnrolled);
  }

  String firstName = '';
  String lastName = '';
  String course = '';
  String year = '';
  bool enrolled = false;

  FutureOr<void> updateStudentButtonClickedEvent(
      UpdateStudentButtonClickedEvent event,
      Emitter<UpdateStudentState> emit) async {
    log('The update button is clicked');
    final students = Students(
        firstName: firstName.isNotEmpty ? firstName : event.students.firstName,
        lastName: lastName.isNotEmpty ? lastName : event.students.lastName,
        course: course.isNotEmpty ? course : event.students.course,
        year: year.isNotEmpty ? year : event.students.year,
        enrolled: enrolled);

    log('The student data is: ${event.students.firstName}, $lastName, $course, $year, $enrolled');
    emit(UpdateStudentLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final response =
          await apiServices.updateStudents(event.students.id!, students);
          log('The updated student info is: $students');
        log('The student Id when updating is: ${event.students.id}');
      if (response['statusCode'] == 200) {
        emit(UpdateStudentSuccess());
      }else {
         emit(UpdateStudentFailed(
          error: 'The error is in storing student:  ${response['statusCode']}'));
        log('The response when updating student is: ${response['statusCode']}');
      }
    } catch (e) {
      emit(UpdateStudentFailed(
          error: 'The erore is in storing student: ${e.toString()}'));
    }
  }

  FutureOr<void> updateStudentFirstName(
      UpdateStudentFirstName event, Emitter<UpdateStudentState> emit) async {
    firstName = event.firstName;
  }

  FutureOr<void> updateStudentLastName(
      UpdateStudentLastName event, Emitter<UpdateStudentState> emit) {
    lastName = event.lastName;
  }

  FutureOr<void> updateStudentCourse(
      UpdateStudentCourse event, Emitter<UpdateStudentState> emit) {
    course = event.course;
  }

  FutureOr<void> updateStudentYear(
      UpdateStudentYear event, Emitter<UpdateStudentState> emit) {
    year = event.year;
  }

  FutureOr<void> updateStudentEnrolled(
      UpdateStudentEnrolled event, Emitter<UpdateStudentState> emit) {
    enrolled = event.enrolled;
  }
}
