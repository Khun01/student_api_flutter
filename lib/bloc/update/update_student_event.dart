part of 'update_student_bloc.dart';

sealed class UpdateStudentEvent extends Equatable {
  const UpdateStudentEvent();

  @override
  List<Object> get props => [];
}

class UpdateStudentButtonClickedEvent extends UpdateStudentEvent{
  final Students students;

  const UpdateStudentButtonClickedEvent({required this.students});
}

class UpdateStudentFirstName extends UpdateStudentEvent { 
  final String firstName;

  const UpdateStudentFirstName({
    required this.firstName,
  });
}

class UpdateStudentLastName extends UpdateStudentEvent {
  final String lastName;

  const UpdateStudentLastName({
    required this.lastName,
  });
}

class UpdateStudentCourse extends UpdateStudentEvent {
  final String course;

  const UpdateStudentCourse({
    required this.course,
  });
}

class UpdateStudentYear extends UpdateStudentEvent {
  final String year;

  const UpdateStudentYear({
    required this.year,
  });
}

class UpdateStudentEnrolled extends UpdateStudentEvent {
  final bool enrolled;

  const UpdateStudentEnrolled({
    required this.enrolled,
  });
}