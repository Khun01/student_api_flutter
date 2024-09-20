import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_api/models/students.dart';
import 'package:student_api/services/api_services.dart';

part 'delete_student_event.dart';
part 'delete_student_state.dart';

class DeleteStudentBloc extends Bloc<DeleteStudentEvent, DeleteStudentState> {
  final ApiServices apiServices;
  DeleteStudentBloc({required this.apiServices}) : super(DeleteStudentInitial()) {
    on<DeleteStudentButtonClicked>(deleteStudentButtonClicked);
  }

  FutureOr<void> deleteStudentButtonClicked(DeleteStudentButtonClicked event, Emitter<DeleteStudentState> emit) async {
    log('The delete button is clicked');
    emit(DeleteStudentLoading());
    try{
      await Future.delayed(const Duration(seconds: 2));
      final response = await apiServices.deleteStudents(event.student.id!);
      if(response['statusCode'] == 200){
        emit(DeleteStudentSuccess());
      }else{
        emit(const DeleteStudentFailed(error: 'Failed to delete student'));
      }
    }catch(e){
      emit(DeleteStudentFailed(error: e.toString()));
    }
  }
}
