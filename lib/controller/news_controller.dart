import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:newsapi/model/news_model.dart';

class NewsController extends GetxController{
  getDate(String category)async{

   final url= Uri.parse('https://newsapi.org/v2/top-headlines?country=eg&category=${category}&'
       'apiKey=eeb00b620a254626900df08098e73d29');
    http.Response respone= await http.get(url);
    if(respone.statusCode==200){
      try {
        return Articles.fromJson(jsonDecode(respone.body));
      }catch(e){
        Get.snackbar('error', e.toString());
      }
    }
  }
}