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

  //질문의 응답지 선택시 사용자가 어떤 질문에 어떤 대답을 했는지 저장
  Future<void> saveSelection(String userId, String questionId, String optionId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/selections'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'question_id': questionId,
        'option_id': optionId
      }),
    );

    if (response.statusCode == 200) {
      print('Selection saved successfully');
    } else {
      print('Failed to save selection');
    }
  }

  //특정 질문에 대한 각 응답 개수 가져오기
  Future<List<dynamic>> getSelectionCountByQuestion(String questionId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/selections/selection-count/$questionId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load selection counts');
    }
  }

  Future<List<dynamic>> getUserSelections(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/selections/user/$userId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user selections');
    }
  }
}

