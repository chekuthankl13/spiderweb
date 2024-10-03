class EmployeeList{
  final List<EmployeeModel> employees;

  EmployeeList({required this.employees});
  factory EmployeeList.fromJson(List<dynamic>json)=> EmployeeList(
    employees: List<EmployeeModel>.from((json).map((e)=> EmployeeModel.fromJson(e)).toList() ),
    );
}

class EmployeeModel {
  final String id;
  final String name;
  final String lastName;
  final String departmentId;
  final String departmentName;
  final String departmentLocation;
  final String salary;
  final String projectId;
  final String projectName;
  final String projectStatus;

  EmployeeModel({required this.id, required this.name, required this.lastName, required this.departmentId, required this.departmentName, required this.departmentLocation, required this.salary, required this.projectId, required this.projectName, required this.projectStatus});


factory EmployeeModel.fromJson(Map<String,dynamic>json)=> EmployeeModel(id: json['EmployeeID'].toString(), name: json['FirstName'].toString(), 
lastName: json['LastName'], departmentId: json['DepartmentID'].toString(), departmentName: json['DepartmentName'].toString(),
 departmentLocation: json['Location'].toString(),
  salary: json['Salary'].toString(), projectId: json['ProjectID'].toString(),
  projectName: json['ProjectName'].toString(), projectStatus: json['Status'].toString());
  

 }

//  "EmployeeID":1,"FirstName":"John","LastName":"William","DepartmentID":2,"DepartmentName":"IT","Location":"San Francisco","ProjectID":1,"ProjectName":"Project Alpha","AssignedDate":"2023-01-10","Status":"In Progress"}