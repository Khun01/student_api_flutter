part of 'show_student_bloc.dart';

sealed class ShowStudentEvent extends Equatable {
  const ShowStudentEvent();

  @override
  List<Object> get props => [];
}

class FetchStudents extends ShowStudentEvent {}

