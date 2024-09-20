part of 'update_student_bloc.dart';

sealed class UpdateStudentState extends Equatable {
  const UpdateStudentState();
  
  @override
  List<Object> get props => [];
}

final class UpdateStudentInitial extends UpdateStudentState {}

class UpdateStudentSuccess extends UpdateStudentState{}

class UpdateStudentLoading extends UpdateStudentState{}

class UpdateStudentFailed extends UpdateStudentState{
  final String error;

  const UpdateStudentFailed({required this.error});
}
