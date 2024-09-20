part of 'show_student_bloc.dart';

sealed class ShowStudentState extends Equatable {
  const ShowStudentState();
  
  @override
  List<Object> get props => [];
}

final class StoreStudentInitial extends ShowStudentState {}

class ShowStudentSuccess extends ShowStudentState{
  final List<Students> student;

  const ShowStudentSuccess({required this.student});
}

class ShowStudentLoading extends ShowStudentState{
  final List<Students> student;

  const ShowStudentLoading({required this.student});
}

class ShowStudentFailed extends ShowStudentState{
  final String error;

  const ShowStudentFailed({required this.error});
}