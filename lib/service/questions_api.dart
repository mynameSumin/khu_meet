import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/questions.dart';
import '../models/options.dart';

class QuestionsApi {
  static const String baseUrl = "http://10.0.2.2:3000";

  //질문지 가져오기
  Future<List<Question>> getQuestions() async {
    final response = await http.get(Uri.parse('${baseUrl}/questions'));

    if(response.statusCode == 200){
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Question.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  //질문에 맞는 응답지 가져오기
  Future<List<Option>> getOptions(String questionId) async {
    final response = await http.get(Uri.parse('$baseUrl/options/$questionId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Option.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load options');
    }
  }
}