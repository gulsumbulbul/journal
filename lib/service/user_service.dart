import 'dart:convert';
import 'package:journal/model/users.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String url = "http://localhost:5071/api/Users";

  Future<List<Users>?> getUsers() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var resBody = res.body;
      List<dynamic> decoded = jsonDecode(resBody);
      List<Users> users = decoded.map((e) => Users.fromJson(e)).toList();
      return users;
    } else {
      print("istek başarısız oldu");
    }
  }

  Future<Users?> getUserById(String id) async {
    var res = await http.get(Uri.parse('$url/$id'));
    if (res.statusCode == 200) {
      var resBody = res.body;
      var decoded = jsonDecode(resBody);
      print("Decoded user data: $decoded"); // Gelen veriyi kontrol et
      Users user = Users.fromJson(decoded);
      return user;
    } else {
      print("Kullanıcı getirme isteği başarısız oldu: ${res.statusCode}");
      return null;
    }
  }

  Future<void> createUsers(
      String username, String useremail, String userpassword) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': username,
      'useremail': useremail,
      'userpassword': userpassword,
    });

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 201) {
      print("User successfully created!");
    } else {
      print("Failed to create user: ${response.statusCode}, ${response.body}");
    }
  }
}
