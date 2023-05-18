class Datum {
  String? id;
  String? title;
  String? content;

  Datum({this.id, this.title, this.content});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        content: json['content'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'content': content,
      };
}
