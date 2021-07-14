import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dakowa_app/utils/dataholder.dart';
import 'package:dakowa_app/utils/sharedprefs.dart';
import 'package:dio/dio.dart';

class DashboardHttpService {
  Future<dynamic> userPostsRequest(String userId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/posts/all-posts-by-user";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "userId": userId
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

      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> createGoalRequest(
      String title,
      String mode,
      bool active,
      double maxAmount,
      String note,
      String username,
      String startDate,
      String endDate) async{
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/support/create-goal";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "title": title,
            "mode": mode,
            "active": active,
            "maxAmount": maxAmount,
            "creatorUsername": username,
            "note": note,
            "startDate": startDate,
            "endDate": endDate
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

  Future<dynamic> creatorSupportsRequest(String username) async{
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/user-supports";
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


  Future<dynamic> creatorGoalsRequest(String username) async{
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/support/all-user-goals";
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
      //print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> activateDeactivateGoalRequest(String username, String ref, bool status) async{
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/support/change-goal-status";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "username": username,
            "ref": ref,
            "status": status
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
      //print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> exportSupportersRequest(String username) async{
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/user-export-supporters";
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
      //print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> searchPostsRequest(String query) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/posts/search-posts";
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

      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> deletePostRequest(String userId, String postId) async{
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/posts/delete-post";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "userId": userId,
            "postId": postId
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
      //print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> createPostRequest(String title,
      String content,
      String mediaUrl,
      String username,
      String ownerId,
      String type,
      Uint8List fileBytes) async {
    print("insode http");
    var url = DataHolder.BASE_URL + "api/v1/posts/create-post";
    print(url);
    print(fileBytes);
    var dio = Dio();
    try {
      dio.options.headers = {
        HttpHeaders.acceptHeader: 'multipart/form-data',
        HttpHeaders.contentTypeHeader: 'multipart/form-data'
      };

      FormData formdata;
      formdata = new FormData.fromMap({
        "title": title,
        "content": content,
        "mediaUrl": mediaUrl,
        "username": username,
        "ownerId": ownerId,
        "type": type,
        "media": MultipartFile.fromBytes(fileBytes)//, contentType: MediaType("image", "png")), //application/octet-stream
        // 'media': await MultipartFile.fromFile(file.path, contentType: MediaType("image", "png"))
      });


      //print(file.path);
      print(formdata.fields);
      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: formdata,
        options: Options(contentType: 'multipart/form-data'),
      );
      print("this response");
      print(response.statusCode);
      print(response);

      print("this response ends");
      print("");
      print("");
      print(response.data);
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

  Future<dynamic> searchGoalsRequest(String query, String username) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/support/search-goals";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "query": query,
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

      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> sendMessageRequest(String content, String senderId, String receiverId, String receiverEmail) async {
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/message/create-message";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "content": content,
            "senderId": senderId,
            "receiverId": receiverId,
            "receiverEmail": receiverEmail
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

  Future<dynamic> dakowaBanksRequest() async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/bank/list-banks";
    print(url);
    var dio = Dio();
    try {



      dio.options.connectTimeout = 35000;
      Response response = await dio.get(
        url,

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

  Future<dynamic> verifyBankInfoRequest(String accountNumber, String bankCode) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/bank/verify-bank-info";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "accountNumber": accountNumber,
            "bankCode": bankCode
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


  Future<dynamic> createBankInfoRequest(
      String accountNumber,
      String bankCode,
      String creatorUsername,
      String ownerName,
      String bankName

      ) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/bank/create-bank-info";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "accountNumber": accountNumber,
            "bankCode": bankCode,
            "ownerName": ownerName,
            "bankName": bankName,
            "creatorUsername": creatorUsername
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


  Future<dynamic> editBankInfoRequest(
      String accountNumber,
      String bankCode,
      String creatorUsername,
      String ownerName,
      String bankName,
      int recipId
      ) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/bank/edit-bank-info";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "accountNumber": accountNumber,
            "bankCode": bankCode,
            "ownerName": ownerName,
            "bankName": bankName,
            "creatorUsername": creatorUsername,
            "recipId": recipId
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

  Future<dynamic> editCreatorProfileRequest(
      String name,
      String username,
      double karfa,
      String firstAttribute,
      String secondAttribute,
      String videoUrl) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/edit-profile";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "name": name,
            "username": username,
            "karfa": karfa,
            "firstAttribute": firstAttribute,
            "secondAttribute": secondAttribute,
            "videoUrl": videoUrl
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