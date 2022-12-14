import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../Utils/utils.dart';

abstract class DioService<T> {
  static BuildContext? _context;

  static get context => _context;

  static set buildCtx(BuildContext con) => _context = con;

  Dio dio = Dio();

  static get headers => {
    'X-CSRF-TOKEN':  "",
    // 'Authorization': 'Bearer ${AppData().accessToken}',
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  // static String resovleImage(String name) {
  //   return apiUrl + 'uploads/$name';
  // }
  static List<Map<String, dynamic>> decodeData(String encodedData) {
    final json = jsonDecode(encodedData);

    if (json is List) {
      return json.cast<Map<String, dynamic>>();
    } else {
      return [json].cast<Map<String, dynamic>>();
    }
  }

  static post(String route, data, [Map<String, dynamic>? customHeaders, Function(String)? onProgress]) async {


    Dio dio = Dio();
    try {
      print("$apiUrl$route");
      Response res = await dio.post('$apiUrl$route', data: data, options: Options(
        headers: customHeaders ?? headers,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ),
        onSendProgress: (int sent, int total) {
          if (onProgress != null) onProgress("${(sent * 100) / total}%");
          print("${(sent * 100) / total}%");
        },
      );

      try {
        // showSuccessToast(res.data['message']);
      // ignore: empty_catches
      } catch (e) {}
      print(res.data);
      return res.data;
    } on DioError catch (e) {
      print("exception");
      print(e.error);

      if (e.response?.statusCode == 503) {
        //   showErrorToast("Service unavailable");
      }
      if (e.response?.statusCode == 500) {
        // showErrorToast("Service unavailable");
      }
      if (e.response?.statusCode == 401) {
        // if (AppData().isAuthenticated) {
        //   AppData().signOut();
        // //  showErrorToast("Session expired. Please login again");
        //   //   CustomNavigator.pushReplacement(context, LoginPage());
        // }
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        // showErrorToast(formatError(e.response.data));
        print(e.response!.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.request);
        // print(e.message);
      }
      return e.response?.data['message'];
    }
  }

  static patch(String route, data) async {
    Dio dio = Dio();

    try {
      Response res = await dio.patch("$apiUrl$route",
          data: data, options: Options(headers: headers));
      print("Patch Response: ${res.data}");
      return res.data;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        // if (AppData().isAuthenticated) {
        //   AppData().signOut();
        //   //showErrorToast("Session expired. Please login again");
        // }
      }
      throw e;
    }
  }

  static get(String route) async {
    Dio dio = Dio();
    try {
      Response res = await dio.get("$apiUrl$route");
      print("$apiUrl$route");
      return res.data;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        // if (AppData().isAuthenticated) {
        //   AppData().signOut();
        //   //showErrorToast("Session expired. Please login again");
        // }
      }
      print(e);
    }
  }

  static delete(String route, data) async {
    Dio dio = Dio();
    try {
      Response res = await dio.delete("$apiUrl$route",
          data: data, options: Options(headers: headers));
      print("$apiUrl$route");
      return res;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        // if (AppData().isAuthenticated) {
        //   AppData().signOut();
        // //  showErrorToast("Session expired. Please login again");
        // }
      }
      print(e);
    }
  }

  T parse(Map<String, dynamic> json);
}
