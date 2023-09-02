import 'package:http/http.dart' as http;
import 'dart:convert';
class crud{
  getReq(String url)async{
    try{
      var res=await http.get(Uri.parse(url));
      if(res.statusCode==200)
        {
         var resbody=jsonDecode(res.body);
         return resbody;
        }
      else{
        print("Error ${res.statusCode}");
      }
    }
    catch(e){
        print("Error catch $e");
    }
  }
  postReq(String url,Map data)async{
   // await Future.delayed(Duration(seconds: 2));
    try{
      var res=await http.post(Uri.parse(url),body:data);
      if(res.statusCode==200)
      {
        var resbody=jsonDecode(res.body);
        return resbody;
      }
      else{
        print("Error ${res.statusCode}");
      }
    }
    catch(e){
      print("Error catch $e");
    }
  }
}