import 'dart:convert';
import 'package:journal/model/questions.dart';
import 'package:http/http.dart' as http;

class QuestionService {
  final String url = "http://localhost:5071/api/Questions";

  Future<List<Questions>?> getQuestion() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var resBody = res.body;
      List<dynamic> decoded = jsonDecode(resBody);
      List<Questions> questions =
          decoded.map((e) => Questions.fromJson(e)).toList();
      return questions;
    } else {
      print("istek başarısız oldu");
    }
  }

  Future<void> createQuestions(String question) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'question': question});

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
  }

  Future<void> deleteQuestions(int id) async {
    try {
      final response = await http
          .delete(Uri.parse("http://localhost:5070/api/Questions/$id"));
      if (response.statusCode == 200) {
        getQuestion();
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (error) {
      print(error);
    }
  }
}
