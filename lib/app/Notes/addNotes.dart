import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/component/crud.dart';
import 'package:noteapp/component/customtextform.dart';
import 'package:noteapp/component/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';

class addNotes extends StatefulWidget {
  const addNotes({Key? key}) : super(key: key);

  @override
  State<addNotes> createState() => _addNotesState();
}

class _addNotesState extends State<addNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  crud _crud = crud();
  bool loading = false;
  File? file;

  addNotes() async {
    if (file == null)
      return AwesomeDialog(
          context: context, title: "Hey", body: Text("Upload image"))
        ..show();
    if (formstate.currentState!.validate()) {
      loading = true;
      setState(() {});
      var res = await _crud.postReqFile(
          linkAdd,
          {
            "title": title.text,
            "content": content.text,
            "userid": sharedPreferences.getString("id")
          },
          file!);
      loading = false;
      setState(() {});
      if (res['status'] == "Success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        print("error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
      ),
      body: loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    CustomTextForm(
                      hint: 'Add Title',
                      mycontroller: title,
                      validator: (val) {
                        return validInput(val!, 1, 30);
                      },
                    ),
                    CustomTextForm(
                      hint: 'Add content',
                      mycontroller: content,
                      validator: (val) {
                        return validInput(val!, 2, 200);
                      },
                    ),
                    Container(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          Navigator.of(context).pop();
                                          file = File(xfile!.path);
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          child: Text(" from Galary"),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          Navigator.of(context).pop();
                                          file = File(xfile!.path);
                                          setState(() {

                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          child: Text("from Camera"),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                      },
                      child: Text("choose image"),
                      textColor: Colors.white,
                      color: file == null ? Colors.grey : Colors.lightBlue,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await addNotes();
                      },
                      child: Text("Add"),
                      textColor: Colors.white,
                      color: Colors.lightBlue,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
