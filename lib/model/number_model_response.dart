class NumberModelResponse {
  String? text;
  int? number;
  bool? found;
  String? type;

  NumberModelResponse({this.text, this.number, this.found, this.type});

  factory NumberModelResponse.fromJson(Map<String, dynamic> json) {
    return NumberModelResponse(
      text: json['text'] as String?,
      number: json['number'] as int?,
      found: json['found'] as bool?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'number': number,
        'found': found,
        'type': type,
      };
}
