//질문지
class Question {
  final String id;
  final String questionText;

  Question({required this.id, required this.questionText});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['_id'],
      questionText: json['question_text'],
    );
  }
}
