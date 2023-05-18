import 'datum.dart';

class GetAllNoteResponse {
  List<Datum>? data;

  GetAllNoteResponse({this.data = const []});

  factory GetAllNoteResponse.fromJson(Map<String, dynamic> json) {
    return GetAllNoteResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
