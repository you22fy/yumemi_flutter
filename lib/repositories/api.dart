import 'dart:io';

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

  for (var i = 0; i < retryCount; i++) {
    try {
      final response = await dio
          .get(
            url,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          )
          .timeout(timeout);

      if (200 <= response.statusCode! && response.statusCode! < 300) {
        return response;
      }

      if (i == retryCount - 1) {
        throw const HttpException('Retry count exceeded.');
      }
    } catch (e) {
      if (i == retryCount - 1) {
        throw const HttpException('Retry count exceeded.');
      }
    }
  }

  // この行が実行されるのは、リトライ回数を超えても成功することがなかった場合
  return null;
}
