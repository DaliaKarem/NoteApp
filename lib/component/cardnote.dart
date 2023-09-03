import 'package:flutter/material.dart';
import 'package:noteapp/component/crud.dart';
import 'package:noteapp/constant/linkapi.dart';

class cardnote extends StatelessWidget {
  cardnote(
      {Key? key,
      required this.ontap,
      required this.title,
      required this.content, required this.ondelete})
      : super(key: key);
  final void Function()? ontap;
  final String title;
  final String content;
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
                child: Image.network(
                  "https://icons-for-free.com/iconfiles/png/512/cloud+upload+file+storage+upload+icon-1320190558968694328.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("$title"),
                  subtitle: Text("$content"),
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
