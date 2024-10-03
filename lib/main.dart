import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spiderweb/modules/employeeAdd/cubit/employee_cubit.dart';
import 'package:spiderweb/modules/employeeAdd/repo/employee_add_repo.dart';
import 'package:spiderweb/modules/home/cubit/home_cubit.dart';
import 'package:spiderweb/modules/home/repo/home_repo.dart';
import 'package:spiderweb/spalsh_screen.dart';
import 'package:spiderweb/utils/utils.dart';

void main() {
  runApp(const MainApp());
  configLoading();
}


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (context) => HomeRepo(),), 
       RepositoryProvider(create: (context) => EmployeeAddRepo(),)
    ], child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(context.read<HomeRepo>()),
        ),
        BlocProvider(
          create: (context) => EmployeeCubit(context.read<EmployeeAddRepo>()),
        ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false, 
      navigatorKey: navigatorKey,
      theme: ThemeData(
        
        useMaterial3: true, 
        scaffoldBackgroundColor: Colors.white, 
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.white)
      ),
       builder: EasyLoading.init(),
      home:const SplashScreen()
    ),
    ));
  }
}
