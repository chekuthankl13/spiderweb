import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spiderweb/modules/employeeAdd/models/employee_add_model.dart';

spaceHeight(height) => SizedBox(height: double.parse(height.toString()));

spaceWidth(width) => SizedBox(width: double.parse(width.toString()));

sH(context) => MediaQuery.of(context).size.height;

sW(context) => MediaQuery.of(context).size.width;

Center loading() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.black,
        // color: mainClr,
        ),
  );
}

error(String error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 50,
        ),
        spaceHeight(10),
        Text(error)
      ],
    ),
  );
}

 DataColumn headtile(label)=>DataColumn(label: Text(label,style: TextStyle(color: Colors.white),),);

 rowTile(label,{isEdit=false,void Function()? ontap})=> DataCell(isEdit? TextButton(onPressed: ontap, child: Text(label)):
          Text(label),

      );

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

TextFormField field(
    {required cntr,
    required txt,
   
    required ic,
    date = false,
    void Function()? onTap,
    isRead = false,
    isReq = true,
    number = false}) {
  return TextFormField(
    controller: cntr,
    validator:isReq? (value) {
      if (value!.isEmpty) {
        return "*required";
      } else {
        return null;
      }
    }:null,
    keyboardType: number ? TextInputType.number : TextInputType.text,
    inputFormatters: number ? [FilteringTextInputFormatter.digitsOnly] : null,
    maxLength: number ? 10 : null,
    
    readOnly: isRead ? true : false,
    onTap: isRead ? onTap : null,
    style: const TextStyle(fontSize: 11),
    decoration: InputDecoration(
      counterText: "",
    hintStyle: TextStyle(color: Colors.grey),
      hintText: txt,
      errorStyle: const TextStyle(
        color: Colors.grey,
      ),
      labelStyle: const TextStyle(fontSize: 11, color: Colors.grey),
      prefixIcon: Icon(
        ic,
        size: 20,
        color: Colors.grey.withOpacity(.7),
      ),
      suffixIcon: isRead
          ? Icon(
              Icons.arrow_drop_down,
              size: 20,
              color: Colors.grey.withOpacity(.7),
            )
          : null,
      fillColor: Colors.white,
      filled: true,
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(.3)),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
          borderRadius: BorderRadius.circular(10)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(.3)),
          borderRadius: BorderRadius.circular(10)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black.withOpacity(.3)),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}


utilDialogDepartment(context,
    {required String txt,
    required List<Departments?> item,
    required TextEditingController cntr,
    required TextEditingController idCntr}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Material(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txt,
                
              ),
              spaceHeight(20),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    var data = item[index]!;
                    return Container(
                      // color: Colors.blue[50]!.withOpacity(.3),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              cntr.text = data.name;
                              idCntr.text = data.id;
                              navigatorKey.currentState!.pop();
                            },
                            dense: true,
                            title: Text(
                              data.name,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.black),
                            ),
                          ),
                          Divider(
                            color: Colors.grey[200],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      cntr.clear();
                      idCntr.clear();

                      navigatorKey.currentState!.pop();
                    },
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        foregroundColor: Colors.red),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}



utilDialogProject(context,
    {required String txt,
    required List<Project?> item,
    required TextEditingController cntr,
    required TextEditingController idCntr}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Material(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txt,
                
              ),
              spaceHeight(20),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    var data = item[index]!;
                    return Container(
                      // color: Colors.blue[50]!.withOpacity(.3),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              cntr.text = data.name;
                              idCntr.text = data.id;
                              navigatorKey.currentState!.pop();
                            },
                            dense: true,
                            title: Text(
                              data.name,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.black),
                            ),
                          ),
                          Divider(
                            color: Colors.grey[200],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      cntr.clear();
                      idCntr.clear();

                      navigatorKey.currentState!.pop();
                    },
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        foregroundColor: Colors.red),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

