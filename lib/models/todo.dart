class Todo {
  int? id;
  String content;
  String title;
  String login;
  String? time;

  Todo(
      {this.id,
      required this.login,
      this.time,
      required this.content,
      required this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'time': time,
      'content': content,
      'title': title
    };
  }
}
