import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtm_task/cubit/search_destination_cubit.dart';
import 'package:mtm_task/cubit/search_source_cubit.dart';
import 'package:mtm_task/ui/screens/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/current_location_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () =>  MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CurrentLocationCubit(),),
          BlocProvider(create: (context) => SearchSourceCubit(),),
          BlocProvider(create: (context) => SearchDestinationCubit(),),


        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home:  HomeScreen(),
        ),
      ),

    );
  }
}


