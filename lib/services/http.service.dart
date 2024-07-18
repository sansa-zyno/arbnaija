import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:surebetcalc/constants/api.dart';

class HttpService {
  static String host = Api.baseUrl;
  static Dio dio = Dio();

  //for get api calls
  static Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";
    return dio.get(
      uri,
    );
  }

  //for post api calls
  static Future<Response> post(
    String url,
    body, {
    bool includeHeaders = true,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";
    print(url);
    return dio.post(uri,
        data: body,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ));
  }

  //for post api calls with file upload
  static Future<Response> postWithFiles(
    String url,
    body,
  ) async {
    //preparing the api uri/url
    String uri = "$host$url";
    Response response;
    try {
      response = await dio.post(
        uri,
        data: FormData.fromMap(body),
      );
    } catch (error) {
      log(error.toString());
      response = error as Response;
    }

    return response;
  }

  //for patch api calls
  /*Future<Response> patch(String url, Map<String, dynamic> body) async {
    String uri = "$host$url";
    return dio.patch(
      uri,
      data: body,
      options: Options(
        headers: await getHeaders(),
      ),
    );
  }*/

  //for delete api calls
  /*Future<Response> delete(
    String url,
  ) async {
    String uri = "$host$url";
    return dio.delete(
      uri,
      options: Options(
        headers: await getHeaders(),
      ),
    );
  }*/

  /*Response formatDioExecption(DioError ex) {
    var response = Response(requestOptions: ex.requestOptions);
    response.statusCode = 400;
    try {
      if (ex.type == DioErrorType.connectTimeout) {
        response.data = {
          "message":
              "Connection timeout. Please check your internet connection and try again",
        };
      } else {
        response.data = {
          "message": ex.message ??
              "Please check your internet connection and try again",
        };
      }
    } catch (error) {
      response.statusCode = 400;
      response.data = {
        "message": error.message ??
            "Please check your internet connection and try again",
      };
    }

    return response;
  }*/
}
