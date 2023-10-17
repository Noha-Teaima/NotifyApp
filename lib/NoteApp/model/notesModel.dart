class notesModel {
  String? title;
  String? body;
  num? id;
  num? userId;

  notesModel({this.body, this.id, this.title, this.userId});

  notesModel.fromJson(Map json) {
    title = json["title"];
    body = json["body"];
    id = json["id"];
    userId = json["userId"];
  }
}
