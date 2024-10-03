import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spiderweb/modules/employeeAdd/cubit/employee_cubit.dart';
import 'package:spiderweb/modules/employeeAdd/repo/employee_add_repo.dart';
import 'package:spiderweb/modules/employeeAdd/ui/employee_add_Screen.dart';
import 'package:spiderweb/modules/home/cubit/home_cubit.dart';
import 'package:spiderweb/modules/home/repo/home_repo.dart';
import 'package:spiderweb/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController statusCntr = TextEditingController();
  TextEditingController salaryCntr = TextEditingController();

  @override
  void dispose() {
    statusCntr.dispose();
    salaryCntr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "POC",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) =>
                            EmployeeCubit(context.read<EmployeeAddRepo>())
                              ..loadData(),
                        child: EmployeeAddScreen(),
                      ),
                    ),
                  ).then((value){
                    if (value != null && value == true) {
                      BlocProvider.of<HomeCubit>(context).fetchEmployee();
                    }
                  });
                },
                icon: Icon(
                  Icons.person_add_alt,
                  color: Colors.white,
                ))
          ],
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is Homeupdated) {
              context.read<HomeCubit>().fetchEmployee();
            }
          },
          builder: (context, state) {
            if (state is HomeLoading) {
              return loading();
            }
            if (state is HomeLoadError) {
              return error(state.error);
            }

            if (state is HomeLoaded) {
              return body(context, state);
            }
            return Container();
          },
        ));
  }

  Widget body(BuildContext context, HomeLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor:
                WidgetStateColor.resolveWith((states) => Colors.green),
            columns: [
              headtile("ID"),
              headtile("Employee name"),
              headtile("EMployee last name"),
              headtile("Salary"),
              headtile("Department"),
              headtile("Project"),
              headtile("Status"),
              headtile(""),
              headtile(""),
            ],
            rows: List.generate(
              state.employees.length,
              (rowIndex) {
                var data = state.employees[rowIndex];
                return DataRow(cells: [
                  rowTile(data.id),
                  rowTile(data.name),
                  rowTile(data.lastName),
                  rowTile(data.salary),
                  rowTile(data.departmentName),
                  rowTile(data.projectName),
                  rowTile(data.projectStatus),
                  rowTile(
                    "Edit Status",
                    isEdit: true,
                    ontap: () async {
                      statusCntr.text = data.projectStatus;
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: Text(
                            "Edit project status",
                            style: TextStyle(fontSize: 15),
                          ),
                          content: TextFormField(
                            controller: statusCntr,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  navigatorKey.currentState!.pop();
                                },
                                child: Text("cancel")),
                            TextButton(
                                onPressed: () async {
                                  EasyLoading.show(status: "submiting..");
                                  var res =
                                      await BlocProvider.of<HomeCubit>(context)
                                          .updateStatus(
                                              empId: data.id,
                                              status:
                                                  statusCntr.text.toString(),
                                              proId: data.projectId);
                                  if (res['status'] == "ok") {
                                    EasyLoading.dismiss();
                                    navigatorKey.currentState!.pop();
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "successfully updated !!")));
                                    // ignore: use_build_context_synchronously
                                    navigatorKey.currentState!
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (_) => BlocProvider(
                                                  create: (context) =>
                                                      HomeCubit(context
                                                          .read<HomeRepo>())
                                                        ..fetchEmployee(),
                                                  child: HomeScreen(),
                                                )));
                                  } else {
                                    EasyLoading.dismiss();
                                    navigatorKey.currentState!.pop();
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "some error occurred-- ${res['message']}")));
                                  }
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.green),
                                child: Text("submit"))
                          ],
                        ),
                      );
                    },
                  ),
                  rowTile(
                    "Edit Salary",
                    isEdit: true,
                    ontap: () async {
                      salaryCntr.text = data.salary;
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: Text(
                            "Edit Employee Salary",
                            style: TextStyle(fontSize: 15),
                          ),
                          content: TextFormField(
                            controller: salaryCntr,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  navigatorKey.currentState!.pop();
                                },
                                child: Text("cancel")),
                            TextButton(
                                onPressed: () async {
                                  EasyLoading.show(status: "submiting..");
                                  var res =
                                      await BlocProvider.of<HomeCubit>(context)
                                          .updateSalary(
                                    empId: data.id,
                                    salary: salaryCntr.text.toString(),
                                  );
                                  if (res['status'] == "ok") {
                                    EasyLoading.dismiss();
                                    navigatorKey.currentState!.pop();
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "successfully updated !!")));
                                    // ignore: use_build_context_synchronously
                                    navigatorKey.currentState!
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (_) => BlocProvider(
                                                  create: (context) =>
                                                      HomeCubit(context
                                                          .read<HomeRepo>())
                                                        ..fetchEmployee(),
                                                  child: HomeScreen(),
                                                )));
                                  } else {
                                    EasyLoading.dismiss();
                                    navigatorKey.currentState!.pop();
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "some error occurred-- ${res['message']}")));
                                  }
                                },
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.green),
                                child: Text("submit"))
                          ],
                        ),
                      );
                    },
                  )
                ]);
              },
            ),
            border: TableBorder.all(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
