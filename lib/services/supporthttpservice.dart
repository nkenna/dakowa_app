import 'dart:convert';
import 'dart:io';

import 'package:dakowa_app/utils/dataholder.dart';
import 'package:dakowa_app/utils/sharedprefs.dart';
import 'package:dio/dio.dart';

class SupportHttpService {

  Future<dynamic> userProfileSupportRequest(String username) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/user-profile";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "username": username
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

  Future<dynamic> goalProfileSupportRequest(String username, String ref) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/support/retrieve-goal";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "username": username,
            "ref": ref
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

  Future<dynamic> creatorSupportRequest(
      String paymentRef,
      String supporterEmail,
      String name,
      String note,
      bool anonymous,
      int quantity,
      String username) async{
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/support/create-support";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "paymentRef": paymentRef,
            "supporterEmail": supporterEmail,
            "name": name,
            "anonymous": anonymous,
            "creatorUsername": username,
            "quantity": quantity,
            "note": note
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

  Future<dynamic> goalSupportRequest(
      String paymentRef,
      String supporterEmail,
      String name,
      String note,
      bool anonymous,
      String username,
      String ref) async{
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/support/create-goal-support";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "paymentRef": paymentRef,
            "supporterEmail": supporterEmail,
            "name": name,
            "anonymous": anonymous,
            "creatorUsername": username,
            "ref": ref,
            "note": note
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


  Future<dynamic> creatorSupportersRequest(String username) async{
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/user-supporters";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "username": username
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