import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/component/crud.dart';
import 'package:noteapp/component/customtextform.dart';
import 'package:noteapp/component/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate=GlobalKey();
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  crud _crud=crud();
  Login()async{
    if(formstate.currentState!.validate())
      {
        var res=await _crud.postReq(linkLogin,{
          "email":email.text,
          "password":pass.text,
        });
        if(res['status']=="Success")
          {
            sharedPreferences.setString("id", res['data']['id'].toString());
            sharedPreferences.setString("username", res['data']['username']);
            sharedPreferences.setString("email", res['data']['email']);

            Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
          }
        else{
          AwesomeDialog(context: context,title: "Error:",body: Text("Your Email or Password Wrong"))..show();
        }
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       padding: EdgeInsets.all(10),
       child: ListView(
         children: [
           Form(
             key: formstate,
               child: Column(
                 children: [
                   Image.network("https://d1csarkz8obe9u.cloudfront.net/posterpreviews/black-and-blue-colors-app-icon-logo-template-design-ea17c11980a54ba90681c66908ed462d_screen.jpg?ts=1616195504",width: 200,height: 200,),
                   CustomTextForm(
                     validator: (val ) {
                       return validInput(val!,2,10);
                     },
                     mycontroller: email,
                     hint: "Email",),
                   CustomTextForm(
                     validator: (val ) {
                       return validInput(val!,2,10);
                     },
                     mycontroller: pass,
                     hint: "Password",),
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                     child: ElevatedButton(
                         onPressed: ()async{
                           await Login();
                         }, child:Text("Login",style: TextStyle(color: Colors.white),) ),
                   ),
                   Container(height: 10,),
                   InkWell(child: Text("Sign Up"),onTap: (){
                     Navigator.of(context).pushNamed("signup");
                   },)
                 ],
               )
           )
         ],
       ),
     ),
    );
  }
}
