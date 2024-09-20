part of 'store_student_bloc.dart';

sealed class StoreStudentState extends Equatable {
  const StoreStudentState();
  
  @override
  List<Object> get props => [];
}

final class StoreStudentInitial extends StoreStudentState {}

class StoreStudentFailed extends StoreStudentState{
  final String error;

  const StoreStudentFailed({required this.error});
}

class StoreStudentLoading extends StoreStudentState{}

class StoreStudentSuccess extends StoreStudentState{}
