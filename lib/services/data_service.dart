import 'dart:convert';
import 'package:http/http.dart' as http;

class DataService{
  static Map<String,Map<String,dynamic>?> data = Map();
  loadData() async{
    String url = "https://opso-935f7-default-rtdb.firebaseio.com/Programs.json";
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        final res = response.body;
        final result = jsonDecode(res);
        data["GirlScriptSummerOfCode"] = result["GirlScriptSummerOfCode"];
        data["GoogleSummerOfCode"] = result["GoogleSummerOfCode"];
        //print(data["GirlScriptSummerOfCode"]);
      }else{
        print("$response Something went wrong");
      }
    }catch(e){
      print(e);
    }
  }
}