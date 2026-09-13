import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:task_manager_app/controller/auth_controller.dart';
import 'package:task_manager_app/models/api_response.dart';

class ApiCaller {
  static Future<ApiResponse> getRequest({required String url}) async {
    try{
    Response response = await get(Uri.parse(url),
    headers: {
      'token' : AuthController.usertoken ?? ''
    }
    );
    log("URL ====> $url");
    log("Response Status ====> ${response.statusCode}");
    log("Response Body ====> ${response.body}");

    if(response.statusCode == 200 ){
      final decodedData = jsonDecode(response.body);

      return ApiResponse(
          responseCode: response.statusCode,
          responseData: decodedData,
          isSuccess: true
      );
    }
    else{
      return ApiResponse(
          responseCode: response.statusCode,
          responseData: null,
          isSuccess: false,
          errorMessage: _getErrorMessage(response),
      );
    }
  }catch (e){
      log("GET Request Error: $e");
      return ApiResponse(
        responseCode: -1,
        responseData: null,
        isSuccess: false,
        errorMessage: "Network error occurred: $e",
      );
    }
}


  static Future<ApiResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'token': AuthController.usertoken ?? '',
        },
        body: body != null ? jsonEncode(body) : null,
      );

      log("URL ====> $url");
      log("Response Status ====> ${response.statusCode}");
      log("Response Body ====> ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
          responseCode: response.statusCode,
          responseData: decodedData,
          isSuccess: true,
        );
      } else {
        return ApiResponse(
          responseCode: response.statusCode,
          responseData: null,
          isSuccess: false,
          errorMessage: _getErrorMessage(response),
        );
      }
    } catch (e) {
      log("POST Request Error: $e");
      return ApiResponse(
        responseCode: -1,
        responseData: null,
        isSuccess: false,
        errorMessage: "Network error occurred: $e",
      );
    }
  }

  static String _getErrorMessage(Response response) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map && decoded.containsKey('status')) {
        return decoded['status'].toString();
      }
    } catch (_) {
    }

    if (response.statusCode == 429) {
      return "Too many requests. Please wait a moment and try again.";
    }
    return response.body.isNotEmpty ? response.body : "Something went wrong (${response.statusCode})";
  }
}