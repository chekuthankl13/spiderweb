class EmployeeAddModel {
  final List<Departments> departments;
  final List<Project> projects;

  EmployeeAddModel({required this.departments, required this.projects});

  factory EmployeeAddModel.fromJson(Map<String,dynamic>json)=>EmployeeAddModel(
    departments: List<Departments>.from((json['departments'] as List).map((e)=>Departments.fromJson(e)).toList()) , 
    projects:List<Project>.from((json['projects'] as List).map((e)=>Project.fromJson(e)).toList()) ,
    );
}

class Departments {
final String id;
final String name;
final String location;

  Departments({required this.id, required this.name, required this.location});

  factory Departments.fromJson(Map<String,dynamic>json)=>Departments(id: json['DepartmentID'].toString(),
   name: json['DepartmentName'].toString(),
    location: json['Location'].toString());
}
// {"DepartmentID":1,"DepartmentName":"HR","Location":"New York"},

class Project {
final String id;
final String name;
final String budget;
final String startDate;
final String endDate;

  Project({required this.id, required this.name, required this.budget, required this.startDate, required this.endDate});

  factory Project.fromJson(Map<String,dynamic>json)=> Project(id: json['ProjectID'].toString(), 
  name: json['ProjectName'].toString(), budget: json['Budget'].toString(), startDate: json['StartDate'].toString(),
   endDate: json['EndDate'].toString());
}
// [{"ProjectID":1,"ProjectName":"Project Alpha","Budget":100000.00,"StartDate":"2023-01-01","EndDate":"2023-12-31"},
