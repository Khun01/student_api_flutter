part of 'store_student_bloc.dart';

sealed class StoreStudentEvent extends Equatable {
  const StoreStudentEvent();

  @override
  List<Object> get props => [];
}

class StoreStudentButtonClicked extends StoreStudentEvent {
  final List<Students> students;
  final ShowStudentBloc showStudentBloc;

  const StoreStudentButtonClicked({required this.students, required this.showStudentBloc});
}

class StoreStudentFirstName extends StoreStudentEvent {
  final String firstName;

  const StoreStudentFirstName({
    required this.firstName,
  });
}

class StoreStudentLastName extends StoreStudentEvent {
  final String lastName;

  const StoreStudentLastName({
    required this.lastName,
  });
}

class StoreStudentCourse extends StoreStudentEvent {
  final String course;

  const StoreStudentCourse({
    required this.course,
  });
}

class StoreStudentYear extends StoreStudentEvent {
  final String year;

  const StoreStudentYear({
    required this.year,
  });
}

class StoreStudentEnrolled extends StoreStudentEvent {
  final bool enrolled;

  const StoreStudentEnrolled({
    required this.enrolled,
  });
}
