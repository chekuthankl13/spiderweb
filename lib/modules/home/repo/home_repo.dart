import 'package:spiderweb/modules/home/model/employee_model.dart';
import 'package:spiderweb/services/api_services.dart';

class HomeRepo {
  getEMployees()async{
    var res = await ApiServices().getEmployee();
    if (res['status'] == "ok") {
      return {"status":"ok", "data":EmployeeList.fromJson(res['data'])};
    } else {
      return {"status":"!ok", "message":res['message']};
    }
  }

 Future<Map<String,dynamic>>  updateProject({required empID,required proId,required status})async{
    var res = await ApiServices().updateStatus(empID: empID, proId: proId, status: status);
    if (res['status']=="ok") {
      return {"status":"ok"};
    }else{
      return {"status":"!ok", "message":res['message']};

    }
  }

  Future<Map<String,dynamic>>  updateSalary({required empID,required salary})async{
    var res = await ApiServices().updateSalary(empID: empID, salary: salary);
    if (res['status']=="ok") {
      return {"status":"ok"};
    }else{
      return {"status":"!ok", "message":res['message']};

    }
  }

  

}