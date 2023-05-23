import 'dart:convert';

import 'package:api_reference/data/url.dart';
import 'package:api_reference/model/create_note_response.dart';
import 'package:api_reference/model/get_all_note_response/datum.dart';
import 'package:api_reference/model/get_all_note_response/get_all_note_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class ApiCalls {
  Future<CreateNoteResponse?> createNote(CreateNoteResponse response);
  Future<void> getNote();
}

class NoteDb extends ApiCalls {
  // singleton
  NoteDb._internal();
  static NoteDb instance = NoteDb._internal();
  factory() {
    return instance;
  }

  final dio = Dio();
  final url = URL();

  ValueNotifier<List<Datum>> noteNotifier = ValueNotifier([]);

  NoteDb() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.json,
    );
  }

  @override
  Future<CreateNoteResponse?> createNote(CreateNoteResponse response) async {
    try {
      final result =
          await dio.post(url.addNoteEndpoint, data: response.toJson());
      return CreateNoteResponse.fromJson(result.data);
    } on DioError catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  getNote() async {
    final result = await dio.get(url.baseUrl + url.getAllNoteEndpoint);
    final getNote = GetAllNoteResponse.fromJson(result.data);
    if (getNote.data != null) {
      noteNotifier.value.clear();
      noteNotifier.value.addAll(getNote.data!.reversed);
    } else {
      noteNotifier.value.clear();
    }
  }

  Datum? getNoteById(String id) {
    try {
      return noteNotifier.value.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }
}
