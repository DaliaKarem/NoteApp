import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteapp/component/crud.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/model/noteModel.dart';

class cardnote extends StatelessWidget {
  cardnote(
      {Key? key,
      required this.ontap,
      required this.note,
      required this.ondelete})
      : super(key: key);
  final void Function()? ontap;
  final Note note;
  final void Function()? ondelete;
  crud _crud=crud();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.file(
                  File("$linkImage/${note.notesImg}"),
                 // "$linkImage/${note.notesImg}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,

                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${note.notesTitle}"),
                  subtitle: Text("${note.notesContent}"),
                  trailing: IconButton(
                    icon:Icon(Icons.delete,color: Colors.red,) ,
                    onPressed: ondelete
                  )
                ))
          ],
        ),
      ),
    );
  }
}
