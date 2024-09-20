part of 'delete_student_bloc.dart';

sealed class DeleteStudentEvent extends Equatable {
  const DeleteStudentEvent();

  @override
  List<Object> get props => [];
}

class DeleteStudentButtonClicked extends DeleteStudentEvent{
  final Students student;

  const DeleteStudentButtonClicked({required this.student});
}
