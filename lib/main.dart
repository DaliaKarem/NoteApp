import 'package:flutter/material.dart';
import 'package:noteapp/app/auth/Success.dart';
import 'package:noteapp/app/auth/login.dart';
import 'package:noteapp/app/auth/signup.dart';
import 'package:noteapp/app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Notes',
      initialRoute: sharedPreferences.getString("id")==null ?"login" :"home" ,
      routes: {
        "login":(context)=>Login(),
        "signup":(context)=>SignUp(),
        "home":(context)=>Home(),
        "success":(context)=>Success(),
      },
    );
  }
}
