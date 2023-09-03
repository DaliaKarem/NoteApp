import 'package:flutter/material.dart';
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

  addNotes() async {
    if (formstate.currentState!.validate()) {
      loading = true;
      setState(() {});
      var res = await _crud.postReq(linkAdd, {
        "title": title.text,
        "content": content.text,
        "userid": sharedPreferences.getString("id")
      });
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
