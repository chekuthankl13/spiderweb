import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spiderweb/modules/employeeAdd/models/employee_add_model.dart';
import 'package:spiderweb/modules/employeeAdd/repo/employee_add_repo.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeAddRepo repo;
  EmployeeCubit(this.repo) : super(EmployeeInitial());

  loadData()async{
    try {
      emit(EmployeeLoading());
      var res = await repo.loadDatas();
      if (res['status']== "ok") {
        var data = res['data'] as EmployeeAddModel;
        emit(EmployeeLoaded(departments: data.departments, projects: data.projects));
      } else {
      emit(EmployeeLoadError(error:res['message']));
        
      }
    } catch (e) {
      emit(EmployeeLoadError(error: e.toString()));
    }
  }

 Future<Map<String, dynamic>> insert({required pID,required first,required last,required status,required hire,required depId,required assignDAte,required salary})async{
    
      var res= await repo.insert(pId: pID, salary: salary, assignDate: assignDAte, last: last, first: first, status: status, hire: hire, depID: depId);
      return res;
    
  }
}
