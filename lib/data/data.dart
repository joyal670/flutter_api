import 'dart:convert';

import 'package:api_reference/data/url.dart';
import 'package:api_reference/model/create_note_response.dart';
import 'package:api_reference/model/get_all_note_response/datum.dart';
import 'package:api_reference/model/get_all_note_response/get_all_note_response.dart';
import 'package:dio/dio.dart';

abstract class ApiCalls {
  Future<CreateNoteResponse?> createNote(CreateNoteResponse response);
  Future<List<Datum>> getNote();
}

class NoteDb extends ApiCalls {
  final dio = Dio();
  final url = URL();

  NoteDb() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.json,
    );
  }

  @override
  Future<CreateNoteResponse?> createNote(CreateNoteResponse response) async {
    final result = await dio.post(url.addNoteEndpoint, data: response.toJson());
    // final resultJson = jsonDecode(result.data as String);
    return CreateNoteResponse.fromJson(result.data);
  }

  @override
  Future<List<Datum>> getNote() async {
    final result =
        await dio.get<GetAllNoteResponse>(url.baseUrl + url.getAllNoteEndpoint);
    if (result.data == null) {
      return [];
    } else {
      return result.data!.data!;
    }
  }
}
