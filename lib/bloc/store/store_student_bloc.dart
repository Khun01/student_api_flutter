import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_api/bloc/show/show_student_bloc.dart';
import 'package:student_api/models/students.dart';
import 'package:student_api/services/api_services.dart';

part 'store_student_event.dart';
part 'store_student_state.dart';

class StoreStudentBloc extends Bloc<StoreStudentEvent, StoreStudentState> {
  final ApiServices apiServices;
  StoreStudentBloc({required this.apiServices}) : super(StoreStudentInitial()) {
    on<StoreStudentButtonClicked>(storeStudentButtonClicked);
    on<StoreStudentFirstName>(storeStudentFirstName);
    on<StoreStudentLastName>(storeStudentLastName);
    on<StoreStudentCourse>(storeStudentCourse);
    on<StoreStudentYear>(storeStudentYear);
    on<StoreStudentEnrolled>(storeStudentEnrolled);
  }

  String firstName = '';
  String lastName = '';
  String course = '';
  String year = '';
  bool enrolled = false;

  FutureOr<void> storeStudentButtonClicked(
      StoreStudentButtonClicked event, Emitter<StoreStudentState> emit) async {
    final students = Students(
        firstName: firstName,
        lastName: lastName,
        course: course,
        year: year.isNotEmpty ? year : 'First Year',
        enrolled: enrolled);
        
    log('The store student data is: $firstName, $lastName, $course, $year, $enrolled');
    emit(StoreStudentLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final response = await apiServices.addStudents(students);
      if (response['statusCode'] == 200) {
        event.showStudentBloc.add(FetchStudents());
        emit(StoreStudentSuccess());
      } else {
        emit(const StoreStudentFailed(error: 'Failed to add student'));
      }
    } catch (e) {
      emit(StoreStudentFailed(error: 'The erore is in storing student: ${e.toString()}'));
    }
  }

  FutureOr<void> storeStudentFirstName(
      StoreStudentFirstName event, Emitter<StoreStudentState> emit) {
    firstName = event.firstName;
  }

  FutureOr<void> storeStudentLastName(
      StoreStudentLastName event, Emitter<StoreStudentState> emit) {
    lastName = event.lastName;
  }

  FutureOr<void> storeStudentCourse(
      StoreStudentCourse event, Emitter<StoreStudentState> emit) {
    course = event.course;
  }

  FutureOr<void> storeStudentYear(
      StoreStudentYear event, Emitter<StoreStudentState> emit) {
    year = event.year;
  }

  FutureOr<void> storeStudentEnrolled(
      StoreStudentEnrolled event, Emitter<StoreStudentState> emit) {
    enrolled = event.enrolled;
  }
}
