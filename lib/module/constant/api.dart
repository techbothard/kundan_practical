import 'package:http/http.dart'as http;

class Api{
  static String baseUrl='https://dummyjson.com/';
  static Future<http.Response> get({required String endPoint})async{
    final result= await http.get(Uri.parse(baseUrl+endPoint));
    print(result.statusCode);
   await checkResponse(result);
    return result;

  }
 static Future<void> checkResponse(http.Response response)async{

    switch(response.statusCode){
      case 200||201:
        break;
      case 400:
        throw "StatusCode:400:${response.body}";

      case 500:
        throw "Internet Check";

    }


  }
}