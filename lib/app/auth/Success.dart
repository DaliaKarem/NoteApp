import 'package:flutter/material.dart';
class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Your account has been created successfully !"),
          ),
          MaterialButton(
            textColor: Colors.white,
            color: Colors.lightBlue,
            onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
            },child: Text("Login"),)
        ],
      ),
    );
  }
}
