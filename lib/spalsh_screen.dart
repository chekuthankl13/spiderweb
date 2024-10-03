import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spiderweb/db/db_connection.dart';
import 'package:spiderweb/error_screen.dart';
import 'package:spiderweb/modules/home/cubit/home_cubit.dart';
import 'package:spiderweb/modules/home/repo/home_repo.dart';
import 'package:spiderweb/modules/home/ui/home_screen.dart';
import 'package:spiderweb/services/api_services.dart';
import 'package:spiderweb/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 @override
  void initState() {
    Timer(const Duration(seconds: 2), (){
      if (DbConnection.db.isConnected) {
            navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
              builder: (_)=>BlocProvider(create: (context) => HomeCubit(context.read<HomeRepo>())..fetchEmployee(),
              child: HomeScreen(),)));
        
      } else {
        DbConnection().connect().then((val){
          if (val) {
            ApiServices().getEmployee();
            navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
              builder: (_)=>BlocProvider(create: (context) => HomeCubit(context.read<HomeRepo>())..fetchEmployee(),
            child: HomeScreen(),)));
          } else {
            navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_)=>const ErrorScreen()));
            
          }
        });
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading()
    );
  }
}