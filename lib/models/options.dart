//응답지
class Option {
  final String id;
  final String questionId;
  final String optionText;

  Option({required this.id, required this.questionId, required this.optionText});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['_id'],
      questionId: json['question_id'],
      optionText: json['option_text'],
    );
  }
}