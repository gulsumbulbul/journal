class Answers {
  int? answerid;
  String? date;
  int? questionid;
  String? answer;

  Answers({this.answerid, this.date, this.questionid, this.answer});

  Answers.fromJson(Map<String, dynamic> json) {
    // answerid = int.parse(json["answerid"]);
    answerid = json["answerid"];
    date = json["date"];
    questionid = json["questionid"];
    answer = json["answer"];
  }

  get data => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["answerid"] = answerid;
    data["date"] = date;
    data["questionid"] = questionid;
    data["answer"] = answer;

    return data;
  }
}
