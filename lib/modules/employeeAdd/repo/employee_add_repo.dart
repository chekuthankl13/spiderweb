import 'package:spiderweb/modules/employeeAdd/models/employee_add_model.dart';
import 'package:spiderweb/services/api_services.dart';

class EmployeeAddRepo {

 Future<Map<String,dynamic>> loadDatas()async{
    var res = await ApiServices().loadDeptPro();
    if (res['status'] == "ok") {
      return {"status":"ok","data":EmployeeAddModel.fromJson(res['data'])};
    } else {
      return {"status":"!ok","message":res['message']};
    }
  }


  Future<Map<String,dynamic>>  insert({required pId,required salary,required assignDate,required last,required first,required status,required hire,required depID})async{
    var res = await ApiServices().createEmployee(salary: salary,pid: pId,assigndate: assignDate, first: first, last: last, status:status , deptId: depID, hiredate:hire );
    if (res['status']=="ok") {
      return {"status":"ok"};
    }else{
      return {"status":"!ok", "message":res['message']};

    }
  }
}