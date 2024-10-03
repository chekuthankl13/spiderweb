
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:spiderweb/modules/employeeAdd/cubit/employee_cubit.dart';
import 'package:spiderweb/utils/utils.dart';

class EmployeeAddScreen extends StatefulWidget {
  const EmployeeAddScreen({super.key});

  @override
  State<EmployeeAddScreen> createState() => _EmployeeAddScreenState();
}

class _EmployeeAddScreenState extends State<EmployeeAddScreen> {

TextEditingController nameCntr = TextEditingController();
TextEditingController lastCntr = TextEditingController();
TextEditingController depIdCntr = TextEditingController();
TextEditingController depNameCntr = TextEditingController();
TextEditingController proIdCntr = TextEditingController();
TextEditingController proNameCntr = TextEditingController();
TextEditingController salaryCntr = TextEditingController();
TextEditingController statuscntr = TextEditingController();
TextEditingController dateCntr = TextEditingController();



GlobalKey<FormState> fkey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Employee",style: TextStyle(color: Colors.white),),),
      body: BlocConsumer<EmployeeCubit, EmployeeState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return loading();
          }
          if (state is EmployeeLoadError) {
            return error(state.error);
          }

if (state is EmployeeLoaded){
  return body(context,state);
}

          return Container();
        },
      ),
    );
  }
  
  Widget body(BuildContext context, EmployeeLoaded state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      physics: const ScrollPhysics(),
      child: Form(
        key: fkey,
        child: Column(
        children: [
          spaceHeight(10), 
          field(cntr: nameCntr, txt: "Employee first name", ic: Icons.person), 
          spaceHeight(8),
          field(cntr: lastCntr, txt: "Employee last name", ic: Icons.person), 
          spaceHeight(8),
          field(cntr: salaryCntr, txt: "Salary", ic: Icons.monetization_on), 
          spaceHeight(8),

          field(cntr: dateCntr, txt: "Hire Date", ic: Icons.date_range,isRead: true,onTap: ()async{
            DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      dateCntr.text = formattedDate;
                                    } else {}
          }), 
          spaceHeight(8),
          field(cntr: depNameCntr, txt: "Department", isRead: true, ic: Icons.work, onTap: (){
            utilDialogDepartment(context, txt: "Select Department", item: state.departments, cntr: depNameCntr, idCntr: depIdCntr);
          }), 
          spaceHeight(8),
          field(cntr: proNameCntr, txt: "Project", isRead: true, ic: Icons.work,onTap: (){
            utilDialogProject(context, txt: "Select Project", item: state.projects, cntr: proNameCntr, idCntr: proIdCntr);
          }), 
          spaceHeight(8),
          field(cntr: statuscntr, txt: "Project Status", ic: Icons.stacked_bar_chart), 
          spaceHeight(20),
          ElevatedButton(onPressed: ()async{
            if (fkey.currentState!.validate()) {
              EasyLoading.show(status: "verifying..");
              var res = await context.read<EmployeeCubit>().insert(pID: proIdCntr.text.toString(),
               first: nameCntr.text.toLowerCase(),
                last: lastCntr.text.trim(),
                 status: statuscntr.text.trim(),
                  hire: dateCntr.text.trim(), depId: depIdCntr.text.trim(),
                   assignDAte: dateCntr.text.trim(), salary: salaryCntr.text.trim());
                   if (res['status'] == "ok") {
                     EasyLoading.dismiss();
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("employee created successfully !!")));
                     navigatorKey.currentState!.pop(true);
                   } else {
                     EasyLoading.dismiss();
                     EasyLoading.showError(res['message']);
                   }
            } 
          }, 
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            foregroundColor: Colors.white,backgroundColor: Colors.black),
          child: Text("Submit"))

        ],
      )),
    );
  }
}