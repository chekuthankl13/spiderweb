import 'dart:convert';
import 'dart:developer';

import 'package:spiderweb/db/db_connection.dart';

class ApiServices {
  getEmployee()async{
   try {
      String query = """SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Salary,
    e.DepartmentID,
    d.DepartmentName,
    d.Location,
    a.ProjectID,
    p.ProjectName,
    a.AssignedDate,
    a.Status
FROM 
    employees e
JOIN 
    departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN 
    assignments a ON e.EmployeeID = a.EmployeeID
LEFT JOIN 
    projects p ON a.ProjectID = p.ProjectID
ORDER BY 
    e.EmployeeID;""";
String result = await DbConnection.db.getData(query);

var body = jsonDecode(result);
log(result,name: "result");
return {"status":"ok","data":body};

   } catch (e) {
     return {"status":"error" ,"message":e.toString()};
   }
  }

  updateStatus({required empID,required proId,required status})async{
    try {
      String query = """ UPDATE Assignments SET Status = '$status' WHERE EmployeeID = $empID AND ProjectID = $proId ; """;
     
     log(query);
      var result = await DbConnection.db.writeData(query);
      log(result,name: "update");
      var body = jsonDecode(result);
      if (body['affectedRows'] == 1) {
        return {"status":"ok"};
      } else {
     return {"status":"error" ,"message":"some error occured durinf update"};
        
      }
    } catch (e) {
     return {"status":"error" ,"message":e.toString()};
      
    }
  }

  updateSalary({required empID,required salary})async{
    try {
      String query = """ UPDATE employees SET Salary = '$salary' WHERE EmployeeID = $empID ; """;
     
     log(query);
      var result = await DbConnection.db.writeData(query);
      log(result,name: "update");
      var body = jsonDecode(result);
      if (body['affectedRows'] == 1) {
        return {"status":"ok"};
      } else {
     return {"status":"error" ,"message":"some error occured during update"};
        
      }
    } catch (e) {
     return {"status":"error" ,"message":e.toString()};
      
    }
  }

 Future<Map<String,dynamic>> loadDeptPro()async{
    try {
      String query1 = "SELECT * FROM departments";
      String query2 = "SELECT * FROM projects";
      var res =await Future.wait([
         DbConnection.db.getData(query1), 
         DbConnection.db.getData(query2)
      ]); 
     Map<String,dynamic> data = {"projects":jsonDecode(res[1]), "departments":jsonDecode(res[0])};
//     String query3 = """ALTER TABLE Employees
// ADD CONSTRAINT EmployeeID PRIMARY KEY (ID);""";
// var res = await DbConnection.db.writeData(query3);
// log(res,name: "alter");
     return {"status":"ok","data":data};
    } catch (e) {
     return {"status":"error" ,"message":e.toString()};
      
    }
  }


 createEmployee({first,last,salary,hiredate,deptId,pid,status,assigndate})async{
  try {
    var query = """ SELECT MAX(employeeID)  FROM employees """;
    var res0 = await DbConnection.db.writeData(query);
    var id = int.parse(res0.toString())+1;
    var query1 = """ INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, HireDate) 
VALUES ( $id, '$first', '$last', $deptId, $salary, '$hiredate'); """;
log(query1);
var res = await DbConnection.db.writeData(query1);
log(res,name: "insert");
 var body = jsonDecode(res);
if (body['affectedRows'] == 1) {
  String query2 = """ INSERT INTO Assignments (EmployeeID, ProjectID, AssignedDate, Status) 
VALUES (${body["InsertID"]}, $pid, $assigndate, '$status'); """;
var res2 = await DbConnection.db.writeData(query2);
 var body2 = jsonDecode(res2);

  if (body2['affectedRows'] == 1) {
        return {"status":"ok"};
    
  } else {
     return {"status":"error" ,"message":"some error occured during insertion 2"};
    
  }
} else {
     return {"status":"error" ,"message":"some error occured during insertion "};
  
}
  } catch (e) {
     return {"status":"error" ,"message":e.toString()};
    
  }
 }


}

/*employees 

[{"EmployeeID":1,"FirstName":"Johns","LastName":"Doe","DepartmentID":1,"Salary":99000.00,"HireDate":"2020-01-15"},
{"EmployeeID":2,"FirstName":"Jane","LastName":"Smith","DepartmentID":2,"Salary":75000.00,"HireDate":"2019-03-22"},
{"EmployeeID":3,"FirstName":"Mike","LastName":"Johnson","DepartmentID":1,"Salary":50000.00,"HireDate":"2021-05-30"},
{"EmployeeID":4,"FirstName":"Emil","LastName":"Davis","DepartmentID":5,"Salary":65000.00,"HireDate":"2022-02-10"},
{"EmployeeID":5,"FirstName":"David","LastName":"Wilson","DepartmentID":2,"Salary":70000.00,"HireDate":"2021-06-01"},
{"EmployeeID":6,"FirstName":"Sarah","LastName":"Brown","DepartmentID":4,"Salary":72000.00,"HireDate":"2020-08-15"},
{"EmployeeID":7,"FirstName":"Chris","LastName":"Greens","DepartmentID":1,"Salary":3000.00,"HireDate":"2021-07-20"},
{"EmployeeID":8,"FirstName":"anay","LastName":"aher","DepartmentID":1,"Salary":9900.00,"HireDate":"2024-09-20"},
{"EmployeeID":9,"FirstName":"jnj","LastName":"jnjn","DepartmentID":1,"Salary":66666.00,"HireDate":"2024-09-20"},
{"EmployeeID":10,"FirstName":"Harsh","LastName":"Naidu","DepartmentID":1,"Salary":50000.00,"HireDate":"2024-09-20"},
{"EmployeeID":11,"FirstName":"Nandini","LastName":"naidu3","DepartmentID":3,"Salary":80000.00,"HireDate":"2024-09-26"},
{"EmployeeID":12,"FirstName":"Tony","LastName":"Banner","DepartmentID":2,"Salary":100000.00,"HireDate":"2024-09-18"},
{"EmployeeID":13,"FirstName":"Nandini","LastName":"Naidu9","DepartmentID":3,"Salary":50000.00,"HireDate":"2024-09-21"}]

 **/

/* departments

[{"DepartmentID":1,"DepartmentName":"HR","Location":"New York"},
{"DepartmentID":2,"DepartmentName":"IT","Location":"San Francisco"},
{"DepartmentID":3,"DepartmentName":"Finance","Location":"Chicago"},
{"DepartmentID":4,"DepartmentName":"Marketing","Location":"Los Angeles"},
{"DepartmentID":5,"DepartmentName":"Sales","Location":"Miami"}]

**/ 

/* projects

[{"ProjectID":1,"ProjectName":"Project Alpha","Budget":100000.00,"StartDate":"2023-01-01","EndDate":"2023-12-31"},
{"ProjectID":2,"ProjectName":"Project Beta","Budget":150000.00,"StartDate":"2023-02-01","EndDate":"2023-11-30"},
{"ProjectID":3,"ProjectName":"Project Gamma","Budget":200000.00,"StartDate":"2023-03-01","EndDate":"2024-02-28"},
{"ProjectID":4,"ProjectName":"Project Delta","Budget":120000.00,"StartDate":"2023-05-01","EndDate":"2023-09-30"},
"ProjectID":5,"ProjectName":"Project Epsilon","Budget":175000.00,"StartDate":"2023-06-01","EndDate":"2024-01-15"}]
**/


/* Assignments

[{"AssignmentID":1,"EmployeeID":1,"ProjectID":1,"AssignedDate":"2023-01-10","Status":"In Progress"}
,{"AssignmentID":2,"EmployeeID":2,"ProjectID":1,"AssignedDate":"2023-02-15","Status":"Completed"},
{"AssignmentID":3,"EmployeeID":3,"ProjectID":2,"AssignedDate":"2023-03-01","Status":"in progress"},
{"AssignmentID":4,"EmployeeID":4,"ProjectID":3,"AssignedDate":"2023-03-15","Status":"In Progress"},
{"AssignmentID":5,"EmployeeID":5,"ProjectID":2,"AssignedDate":"2023-04-01","Status":"Not Started"},
{"AssignmentID":6,"EmployeeID":6,"ProjectID":4,"AssignedDate":"2023-05-20","Status":"In Progress"},
{"AssignmentID":7,"EmployeeID":7,"ProjectID":5,"AssignedDate":"2023-07-01","Status":"Completed"},
{"AssignmentID":8,"EmployeeID":8,"ProjectID":1,"AssignedDate":"2024-09-20","Status":"Completed"},
{"AssignmentID":9,"EmployeeID":9,"ProjectID":1,"AssignedDate":"2024-09-20","Status":"Not Started"},
{"AssignmentID":10,"EmployeeID":10,"ProjectID":2,"AssignedDate":"2024-09-20","Status":"No Started"}]

**/