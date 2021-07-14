import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dakowa_app/utils/dataholder.dart';
import 'package:dakowa_app/utils/sharedprefs.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
class LandingHttpService {

  Future<dynamic> userProfileExploreRequest(String userId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/user-profile-explore";
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
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> userNotFollowingRequest(String userId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/all-users-not-followed-explore";
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
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> userFollowersRequest(String userId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/user-followers";
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
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> userFollowingRequest(String userId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/user-following";
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
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

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

  Future<dynamic> createCommentRequest(String content, String commenterId, String userId, String postId, bool isReply, String commentId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/posts/create-comment";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "content": content,
            "commenterId": commenterId,
            "userId": userId,
            "postId": postId,
            "isReply": isReply,
            "commentId": commentId
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

  Future<dynamic> exploreCreatorsRequest(String type) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/explore-creators";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "type": type
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

  Future<dynamic> getExploreGoalsRequest() async{
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/support/all-explore-goals";
    print(url);
    var dio = Dio();
    try {


      dio.options.connectTimeout = 35000;
      Response response = await dio.get(
        url,
        //data: body,
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

  Future<dynamic> upgradeToCreatorRequest(String userId, String newUsername) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/upgrade-to-creator";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "userId": userId,
            "newUsername": newUsername
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

  Future<dynamic> checkUsernameRequest(String username) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/check-username";
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

  Future<dynamic> followUserRequest(String userToFollowId, String followerId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/follow-user";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "userToFollowId": userToFollowId,
            "followerId": followerId
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

  Future<dynamic> unFollowUserRequest(String userToUnFollowId, String followerId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/unfollow-user";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "userToUnfollowId": userToUnFollowId,
            "followerId": followerId
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

  Future<dynamic> editFollowerNameRequest(String userId, String name) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/edit-profile-name";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "userId": userId,
            "name": name
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

  Future<dynamic> editFollowerAvatarRequest(String userId, Uint8List fileBytes) async {
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    print("insode http");
    var url = DataHolder.BASE_URL + "api/v1/user/edit-follower-avatar";
    print(url);
    print(fileBytes);
    var dio = Dio();
    try {
      dio.options.headers = {
        HttpHeaders.acceptHeader: 'multipart/form-data',
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };

      FormData formdata;
      formdata = new FormData.fromMap({
        "userId": userId,
        "avatar": MultipartFile.fromBytes(fileBytes)//, contentType: MediaType("image", "png")), //application/octet-stream
        // 'media': await MultipartFile.fromFile(file.path, contentType: MediaType("image", "png"))
      });


      //print(file.path);
      print(formdata.fields);
      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: formdata,
        options: Options(
            contentType: 'multipart/form-data',
            headers: {

              HttpHeaders.authorizationHeader: 'Bearer ' + token
            }
            ),
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

  Future<dynamic> editFollowerHeaderRequest(String userId, Uint8List fileBytes) async {
    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    print("insode http");
    var url = DataHolder.BASE_URL + "api/v1/user/edit-follower-header-image";
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
        "userId": userId,
        "headerImage": MultipartFile.fromBytes(fileBytes)//, contentType: MediaType("image", "png")), //application/octet-stream
        // 'media': await MultipartFile.fromFile(file.path, contentType: MediaType("image", "png"))
      });


      //print(file.path);
      print(formdata.fields);
      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: formdata,
        options: Options(
            contentType: 'multipart/form-data',
            headers: {

              HttpHeaders.authorizationHeader: 'Bearer ' + token
            }
            ),
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

  Future<dynamic> editEmailNotifRequest(String userId, bool emailNotif) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/change-email-notif-pref";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "userId": userId,
            "emailNotif": emailNotif
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

  Future<dynamic> userPostsAndFollowersPostRequest(String userId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/posts/post-by-following";
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

  Future<dynamic> updateDeviceTokenRequest(String userId, String deviceToken) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "api/v1/user/update-device-token";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "userId": userId,
            "deviceToken": deviceToken
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

  Future<dynamic> likePostRequest(String likedById, String postId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "/api/v1/posts/like-post";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "likedById": likedById,
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

      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> unlikePostRequest(String likedById, String postId) async {

    String token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = DataHolder.BASE_URL + "/api/v1/posts/unlike-post";
    print(url);
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "likedById": likedById,
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

      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

}