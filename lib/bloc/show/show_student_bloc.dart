import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_api/models/students.dart';
import 'package:student_api/services/api_services.dart';

part 'show_student_event.dart';
part 'show_student_state.dart';

class ShowStudentBloc extends Bloc<ShowStudentEvent, ShowStudentState> {
  final ApiServices apiServices;
  ShowStudentBloc({required this.apiServices}) : super(StoreStudentInitial()) {
    on<FetchStudents>(fetchStudents);
  }

  FutureOr<void> fetchStudents(
      FetchStudents event, Emitter<ShowStudentState> emit) async {
    try {
      var student = await apiServices.fetchStudents();
      emit(ShowStudentLoading(student: student));
      await Future.delayed(const Duration(seconds: 2));
      emit(ShowStudentSuccess(student: student));
    } catch (e) {
      log('The error in show student bloc is: $e');
      emit(ShowStudentFailed(error: e.toString()));
    }
  }
}
