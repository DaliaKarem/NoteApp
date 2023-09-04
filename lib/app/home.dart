import 'package:flutter/material.dart';
import 'package:noteapp/app/Notes/EditNotes.dart';
import 'package:noteapp/component/cardnote.dart';
import 'package:noteapp/component/crud.dart';
import 'package:noteapp/constant/linkapi.dart';
import 'package:noteapp/main.dart';
import 'package:noteapp/model/noteModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  crud _crud=crud();
 gatnotes()async{
   var res=await _crud.postReq(linkview, {
     "id": sharedPreferences.getString("id")
   });
   return res;
 }
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
        onPressed: () {
          Navigator.of(context).pushNamed("addNotes");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
                future:gatnotes() ,
                builder: (BuildContext context, AsyncSnapshot snap ){
              if(snap.hasData)
                {
                if(snap.data['status']=='fail')
                  {
                    return Center(child: Text("No Notes"));

                  }
                else{
                  return ListView.builder(
                      itemCount: snap.data['data'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,i){
                        return cardnote(ontap:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                           return editNotes(notes:snap.data['data'][i] ,);
                          }));
                        },  ondelete: () async{
                          var res=await _crud.postReq(linkdelete, {"id":snap.data['data'][i]['notes_id'].toString(),"imgname":snap.data['data'][i]['notes_img'].toString()});
                          if(res['status']=="Success")
                            {
                              Navigator.of(context).pushReplacementNamed("home");
                            }
                          else{
                            print("error");
                          }
                        }, note:Note.fromJson(snap.data['data'][i]) ,);}
                  );
                }
                }
              if(snap.connectionState==ConnectionState.waiting)
                {
                  return Center(child: CircularProgressIndicator(),);
                }
              return Text("Loading............");

                })
          ],
        ),
      ),
    );
  }
}
