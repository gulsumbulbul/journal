class Questions {
  int? id;
  String? question;

  Questions({this.question});

  //from json: jsondan gelen verileri alır
  Questions.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    question = json["question"];
  }

  get data => null;

  //to json: json formatına dönüştürür
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["id"] = id;
    data["question"] = question;

    return data;
  }
}
