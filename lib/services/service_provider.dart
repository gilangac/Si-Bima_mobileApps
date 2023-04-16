import 'package:dio/dio.dart';
import 'package:si_bima/services/service_handler.dart';
import 'package:si_bima/services/service_init.dart';

class ServiceProvider {
  static Future<dynamic> getData(String path) async {
    try {
      Response response = await apiCall().get(path);
      return handleResponse(response);
    } on DioError catch (e) {
      throw handleError(e);
    }
  }

  static Future<dynamic> postData(String path, {Map? data}) async {
    try {
      Response response = await apiCall().post(path, data: data);
      return handleResponse(response);
    } on DioError catch (e) {
      throw handleError(e);
    }
  }

  static Future<dynamic> postDataFile(String path,
      {FormData? data, void Function(int, int)? onSendProgress}) async {
    try {
      Response response = await apiCall()
          .post(path, data: data, onSendProgress: onSendProgress);
      return handleResponse(response);
    } on DioError catch (e) {
      throw handleError(e);
    }
  }

  static Future<dynamic> putData(String path, {Map? data}) async {
    try {
      Response response = await apiCall().put(path, data: data);
      return handleResponse(response);
    } on DioError catch (e) {
      throw handleError(e);
    }
  }

  static Future<dynamic> putDataFile(String path, {FormData? data}) async {
    try {
      Response response = await apiCall().put(path, data: data);
      return handleResponse(response);
    } on DioError catch (e) {
      throw handleError(e);
    }
  }

  static Future<dynamic> deleteData(String path, {Map? data}) async {
    try {
      Response response = await apiCall().delete(path);
      return handleResponse(response);
    } on DioError catch (e) {
      throw handleError(e);
    }
  }
}
