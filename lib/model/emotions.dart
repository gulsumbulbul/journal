class Emotions {
  int? emotionId;
  String? emotionName;
  String? emotionColor;

  Emotions({this.emotionId, this.emotionName, this.emotionColor});

  Emotions.fromJson(Map<String, dynamic> json) {
    emotionId = json["emotionid"];
    emotionName = json["emotionname"];
    emotionColor = json["emotioncolor"];
  }

  get data => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["emotionid"] = emotionId;
    data["emotionname"] = emotionName;
    data["emotioncolor"] = emotionColor;

    return data;
  }
}
