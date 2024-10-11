import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:journal/model/answers.dart';

class AnswerService {
  final String url = "http://localhost:5071/api/Answers";

  Future<List<Answers>?> getAnswers() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var resBody = res.body;
      List<dynamic> decoded = jsonDecode(resBody);
      List<Answers> answers = decoded.map((e) => Answers.fromJson(e)).toList();
      return answers;
    } else {
      print("istek başarısız oldu");
    }
  }

  Future<void> createAnswer(
    DateTime date,
    int questionId,
    String answer,
  ) async {
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'date': date.toIso8601String(),
      'questionId': questionId,
      'answer': answer,
    });
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 201) {
      print("Answer successfully created!");
    } else {
      print(
          "Failed to create answer: ${response.statusCode}, ${response.body}");
    }
  }

  Future<List<Answers>> getTodayAnswers(DateTime date) async {
    var formattedDate = "${date.year}-${date.month}-${date.day}";
    final response = await http.get(Uri.parse(
        "http://localhost:5071/api/Answers/date?date=$formattedDate"));

    if (response.statusCode == 200) {
      var resBody = response.body;
      var decoded =
          jsonDecode(resBody) as List; // JSON'u bir liste olarak ayarla
      List<Answers> answers = decoded
          .map((e) => Answers.fromJson(e))
          .toList(); // Her öğeyi Answers'a çevir
      return answers;
    } else {
      throw Exception('Failed to load answers');
    }
  }

  // Future<List<Answers>> getTodayAnswers(DateTime date) async {
  //   var formattedDate = "${date.year}-${date.month}-${date.day}";
  //   final response = await http.get(Uri.parse(
  //       "http://localhost:5071/api/Answers/date?date=$formattedDate"));

  //   if (response.statusCode == 200) {
  //     var resBody = response.body;
  //     var decoded = jsonDecode(resBody);
  //     List<Answers> answers = decoded.map((e) => Answers.fromJson(e)).toList();
  //     return answers;
  //   } else {
  //     throw Exception('Failed to load answers');
  //   }
  // }

  // Future<void> getTodayAnswers(DateTime date) async {
  //   var formattedDate = "${date.year}-${date.month}-${date.day}";
  //   final response =
  //       await http.get(Uri.parse("http://localhost:5071/api/Answers/date"));

  //   if (response.statusCode == 200) {
  //     var decoded = jsonDecode(response.body);
  //     var answer = decoded.map((e) => Answers.fromJson(e));
  //     return answer;
  //   } else {
  //     throw Exception('Failed to load answers');
  //   }
  // }
}
