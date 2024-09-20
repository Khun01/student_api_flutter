part of 'delete_student_bloc.dart';

sealed class DeleteStudentState extends Equatable {
  const DeleteStudentState();
  
  @override
  List<Object> get props => [];
}

final class DeleteStudentInitial extends DeleteStudentState {}

class DeleteStudentSuccess extends DeleteStudentState{}

class DeleteStudentFailed extends DeleteStudentState{
  final String error;

  const DeleteStudentFailed({required this.error});
}

class DeleteStudentLoading extends DeleteStudentState{}
