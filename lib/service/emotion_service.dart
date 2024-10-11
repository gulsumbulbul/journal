import 'package:journal/model/emotions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmotionService {
  final String url = "http://localhost:5071/api/Emotions";

  Future<List<Emotions>?> getEmotions() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var resBody = res.body;
      List<dynamic> decoded = jsonDecode(resBody);
      List<Emotions> emotions =
          decoded.map((e) => Emotions.fromJson(e)).toList();
      return emotions;
    } else {
      print("istek başarısız oldu");
    }
  }
}
