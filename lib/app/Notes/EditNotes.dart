import 'package:flutter/material.dart';
import 'package:noteapp/component/crud.dart';
import 'package:noteapp/component/customtextform.dart';
import 'package:noteapp/component/valid.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';
class editNotes extends StatefulWidget {
  final notes;
   editNotes({Key? key, this.notes}) : super(key: key);

  @override
  State<editNotes> createState() => _editNotesState();
}

class _editNotesState extends State<editNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  crud _crud = crud();
  bool loading = false;

  editNotes() async {
    if (formstate.currentState!.validate()) {
      loading = true;
      setState(() {});
      var res = await _crud.postReq(linkedit, {
        "title": title.text,
        "content": content.text,
        "noteid": widget.notes['notes_id'].toString()
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
  void initState() {
    title.text=widget.notes['notes_title'];
    content.text=widget.notes['notes_content'];
    super.initState();
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
                hint: widget.notes['notes_title'],
                mycontroller: title,
                validator: (val) {
                  return validInput(val!, 1, 30);
                },
              ),
              CustomTextForm(
                hint: widget.notes['notes_content'],
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
                  await editNotes();
                },
                child: Text("Save"),
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
