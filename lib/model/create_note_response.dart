class CreateNoteResponse {
  String? id;
  String? title;
  String? content;

  CreateNoteResponse({this.id, this.title, this.content});

  // CreateNoteResponse.create(
  //     {required this.id, required this.title, required this.content});

  factory CreateNoteResponse.fromJson(Map<String, dynamic> json) {
    return CreateNoteResponse(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'content': content,
      };
}
