import 'package:flutter/material.dart';
class CustomTextForm extends StatelessWidget {
   CustomTextForm({Key? key, required this.hint, required this.mycontroller, required this.validator}) : super(key: key);
   final String hint;
   final TextEditingController mycontroller;
   final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator:validator ,
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical:8,horizontal: 10 ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black,width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))
          )
        ),
      ),
    );
  }
}
