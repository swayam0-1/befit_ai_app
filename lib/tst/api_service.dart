import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiService{
  final String baseUrl='http://localhost:5000/exercises';
  Future<List<dynamic>> fetchExercise() async{
    final response= await http.get(Uri.parse(baseUrl));
    if(response.statusCode==200){
      return json.decode(response.body);
    }else{
      throw Exception('failed');
    }
  }
}