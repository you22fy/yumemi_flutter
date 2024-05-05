import 'package:dio/dio.dart';
import 'package:yumemi_flutter/utils/constants.dart';

Future<Response?> doGetRequest(
    String path, int retryCount, Duration timeout) async {
  final url = '$apiBaseUrl$path';

  final dio = Dio(
    BaseOptions(
      validateStatus: (status) {
        return status != null;
      },
    ),
  );

  Response? response;
  for (var i = 0; i < retryCount; i++) {
    try {
      response = await dio
          .get(
            url,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          )
          .timeout(timeout);
      break;
    } catch (e) {
      if (i == retryCount - 1) {
        rethrow;
      }
    }
  }
  return response;
}
