part of 'employee_cubit.dart';

sealed class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeInserted extends EmployeeState {}


final class EmployeeLoading extends EmployeeState {}

final class EmployeeLoadError extends EmployeeState {
  final String error;

 const EmployeeLoadError({required this.error});

  @override
  List<Object> get props => [error];
}


final class EmployeeLoaded extends EmployeeState {
  final List<Departments> departments;
  final List<Project> projects;

 const EmployeeLoaded({required this.departments, required this.projects});

 @override
  List<Object> get props => [departments,projects];
}


