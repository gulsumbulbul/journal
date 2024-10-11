class Users {
  int? userid;
  String? username;
  String? useremail;
  String? userpassword;

  Users({this.userid, this.username, this.useremail, this.userpassword});

  //from json: jsondan gelen verileri alır
  Users.fromJson(Map<String, dynamic> json) {
    userid = json["userid"];
    username = json["username"];
    useremail = json["useremail"];
    userpassword = json["userpassword"];
  }

  get data => null;

  //to json: json formatına dönüştürür
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["userid"] = userid;
    data["username"] = username;
    data["useremail"] = useremail;
    data["userpassword"] = userpassword;

    return data;
  }
}
