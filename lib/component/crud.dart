import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'DODO:DODO12'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};
class crud {
  getReq(String url) async {
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        var resbody = jsonDecode(res.body);
        return resbody;
      }
      else {
        print("Error ${res.statusCode}");
      }
    }
    catch (e) {
      print("Error catch $e");
    }
  }

  postReq(String url, Map data) async {
    // await Future.delayed(Duration(seconds: 2));
    try {
      var res = await http.post(Uri.parse(url), body: data,headers:myheaders );
      if (res.statusCode == 200) {
        var resbody = jsonDecode(res.body);
        return resbody;
      }
      else {
        print("Error ${res.statusCode}");
      }
    }
    catch (e) {
      print("Error catch $e");
    }
  }

  postReqFile(String url, Map data, File file) async {
    var req = http.MultipartRequest("POST", Uri.parse(url));
    var mult = http.MultipartFile(
        "notes_img", http.ByteStream(file.openRead()), await file.length(),
        filename: basename(file.path));
    req.headers.addAll(myheaders);
    req.files.add(mult);
    data.forEach((key, value) {
      req.fields[key]=value;
    });
    var request=await req.send();
    var res=await http.Response.fromStream(request);
    if(request.statusCode==200)
      {
        return jsonDecode(res.body);
      }
    else{
      print("Error");
    }
  }
}