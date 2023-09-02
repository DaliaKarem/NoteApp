import 'package:flutter/material.dart';
import 'package:noteapp/component/crud.dart';
import 'package:noteapp/component/customtextform.dart';
import 'package:noteapp/component/valid.dart';
import 'package:noteapp/constant/linkapi.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  crud _crud = crud();
  bool isloading = true;
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController username = TextEditingController();

  signup() async {
   if(formstate.currentState!.validate())
     {
       var res = await _crud.postReq(linkSignup, {
         "username": username.text,
         "email": email.text,
         "password": pass.text
       });
       if (res['status'] == "Success") {
         Navigator.of(context).pushNamedAndRemoveUntil("success", (route) => false);
       } else {
         print("Signup fail");
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
                          Image.network(
                            "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/black-and-blue-colors-app-icon-logo-template-design-ea17c11980a54ba90681c66908ed462d_screen.jpg?ts=1616195504",
                            width: 200,
                            height: 200,
                          ),
                          CustomTextForm(
                            mycontroller: username,
                            hint: "Username",
                            validator: (val ) {
                              return validInput(val!,2,10);
                          },
                          ),
                          CustomTextForm(
                            mycontroller: email,
                            hint: "Email", validator: (val ) {
                            return validInput(val!,2,10);
                          },
                          ),
                          CustomTextForm(
                            mycontroller: pass,
                            hint: "Password",  validator: (val ) {
                            return validInput(val!,2,10);
                          },
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: ElevatedButton(
                                onPressed: () async {
                                  await signup();
                                },
                                child: Text(
                                  "sign up",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          Container(
                            height: 10,
                          ),
                          InkWell(
                            child: Text("Login"),
                            onTap: () {
                              Navigator.of(context).pushNamed("login");
                            },
                          )
                        ],
                      ))
                ],
              ),
            ),
    );
  }
}
