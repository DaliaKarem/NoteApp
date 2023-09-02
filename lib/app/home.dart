import 'package:flutter/material.dart';
import 'package:noteapp/main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),
      actions: [
        IconButton(onPressed: (){
          sharedPreferences.clear();
          Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
        }, icon: Icon(Icons.exit_to_app))
      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            InkWell(
              onTap: (){

              },
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
                          title: Text("title"),
                          subtitle: Text("content"),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
