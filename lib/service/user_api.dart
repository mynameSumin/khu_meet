import 'package:http/http.dart' as http;
import 'dart:convert';
class User {
  final String univ;
  final String email;
  final String college;
  final String department;
  final int studentId;
  final String introduction;
  final String mbti;
  final String name;
  final List<String> imagePaths; // 사진 경로를 저장할 필드

  User(
      this.univ,
      this.email,
      this.college,
      this.department,
      this.studentId,
      this.name,
      this.introduction,
      this.mbti,
      this.imagePaths);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'college': college,
      'department': department,
      'studentId': studentId,
      'introduction': introduction,
      'mbti': mbti,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['univ'] ?? "",
      json['email'],
      json['college'],
      json['department'],
      int.parse(json['studentId']),
      json['name'],
      json['introduction'],
      json['mbti'],
      List<String>.from(json['imagePaths'] ?? []),
    );
  }
}

Future<void> sendUser(User user) async {
  final url = Uri.parse('http://10.0.2.2:3000/users/${Uri.encodeComponent(user.univ)}');

  var request = http.MultipartRequest('POST', url)
    ..headers['Content-Type'] = 'multipart/form-data'
    ..fields['email'] = user.email
    ..fields['name'] = user.name
    ..fields['college'] = user.college
    ..fields['department'] = user.department
    ..fields['studentId'] = user.studentId.toString()
    ..fields['introduction'] = user.introduction
    ..fields['mbti'] = user.mbti;

  // 사진 파일을 추가
  for (String imagePath in user.imagePaths) {
    var file = await http.MultipartFile.fromPath('images', imagePath);
    request.files.add(file);
  }

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      print('User created successfully: ${response.body}');
    } else {
      print('Failed to create user: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error sending user data: $e');
  }
}

Future<Map<String, dynamic>?> loginUser(String email, String univ) async {
  final url = Uri.parse('http://10.0.2.2:3000/login');
  final response = await http.post(
    url,
    headers: {'Content-Type' : 'application/json'},
    body: json.encode({"email": email, "univ" : univ}),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    print("exist");
    return responseBody['user'];
  } else {
    print(response.statusCode);
    print("not exist");
    return null;
  }
}

//같은 학교의 모든 사용자 정보 가져오기
Future<List<User>> fetchUsersFromSameSchool(String univ) async {
  final url = Uri.parse('http://10.0.2.2:3000/users/${Uri.encodeComponent(univ)}');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);
      print(responseBody[1]);
      List<User> users = responseBody.map((data) => User.fromJson(data..['studentId'] = data['studentId'].toString())).toList();
      print("성공");
      return users;
    } else {
      print('Failed to fetch users: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error fetching users: $e');
    return [];
  }
}

