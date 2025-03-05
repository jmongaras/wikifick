import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../models/wikipedia_response_model.dart';
import '../utils/setting.dart';
class GetAllPostRepository {
  final Dio dio = Dio();

  Future<WikipediaResponseModel> getAllPost(languagesController) async {
    try {
      String finalUrl = url(languagesController);
      final response =
      await dio.get(finalUrl);
      var body = response.data is String ? jsonDecode(response.data) : response.data;
      return WikipediaResponseModel.fromJson(body);
    } catch (error, stacktrace) {
      debugPrint("Exception Occurred: $error StackTrace: $stacktrace");
      throw("Exception Occurred: $error StackTrace: $stacktrace");
    }
  }
}