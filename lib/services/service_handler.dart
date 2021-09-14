import 'package:si_bima/services/service_exception.dart';
import 'package:dio/dio.dart';

dynamic handleResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = response.data;
      return responseJson;

    case 201:
      var responseJson = response.data;
      return responseJson;

    case 400:
      throw BadRequestException(
          'Received invalid status code: ${response.statusCode}',
          response.requestOptions.path);

    // case 401:
    // throw BadRequestException(
    //     utf8.decode(response.bodyBytes), response.request?.url.toString());

    case 401:
      throw UnauthorizedException('Unauthorized request, please login first',
          response.requestOptions.path);

    case 500:
      throw UnauthorizedException('Maaf, server kami sedang dalam perbaikan',
          response.requestOptions.path);

    // case 500:

    default:
      throw FetchDataException(
          'Error occured with code: ${response.statusCode}',
          response.requestOptions.path);
  }
}

dynamic handleError(DioError response) {
  switch (response.type) {
    case DioErrorType.cancel:
      throw FetchDataException(
          'Request to API server was cancelled', response.requestOptions.path);

    case DioErrorType.sendTimeout:
      throw ApiNotRespondingException(
          "Opps, it took longer in sending to server",
          response.requestOptions.path);

    case DioErrorType.connectTimeout:
      throw ApiNotRespondingException(
          "Opps, it took longer to respond with server",
          response.requestOptions.path);

    case DioErrorType.receiveTimeout:
      throw ApiNotRespondingException(
          "Opps, it took longer to respond with server",
          response.requestOptions.path);

    case DioErrorType.response:
      if (response.response?.statusCode == 401) {
        throw UnauthorizedException('Unauthorized request, please login first',
            response.requestOptions.path);
      } else {
        throw BadRequestException(
            'Received invalid status code: ${response.response?.statusCode}',
            response.requestOptions.path);
      }

    default:
      throw FetchDataException(
          'Tidak ada koneksi internet', response.requestOptions.path);
  }
}
