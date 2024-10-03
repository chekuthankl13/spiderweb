import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spiderweb/modules/home/model/employee_model.dart';
import 'package:spiderweb/modules/home/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;
  HomeCubit(this.repo) : super(HomeInitial());

  fetchEmployee()async{
    try {
      emit(HomeLoading());
      var res = await repo.getEMployees();
      if (res['status'] == "ok") {
        var data = res['data'] as EmployeeList;
        emit(HomeLoaded(employees: data.employees));
      } else {
      emit(HomeLoadError(error: res['message']));
        
      }
    } catch (e) {
      emit(HomeLoadError(error: e.toString()));
    }
  }

  Future<Map<String, dynamic>> updateStatus({required empId,required status,required proId})async{
    var res = await repo.updateProject(empID: empId, proId: proId, status: status);
 
    return res;
  }

  Future<Map<String, dynamic>> updateSalary({required empId,required salary})async{
    var res = await repo.updateSalary(empID: empId,  salary: salary);
 
    return res;
  }
}
