import 'dart:convert';
import 'dart:io';

import 'package:dakowa_app/utils/dataholder.dart';
import 'package:dakowa_app/utils/sharedprefs.dart';
import 'package:dio/dio.dart';

class SearchHttpService {
  Future<dynamic> searchQueryRequest(String query) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/search";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "query": query
          }
      );
      print(body);

      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer ' + token
            }
        ),
      );
      print("this response");
      print(response.statusCode);
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }
}