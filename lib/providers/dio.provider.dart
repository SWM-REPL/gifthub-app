import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import 'package:gifthub/providers/token.provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final token = ref.watch(tokensNotifierProvider);

  final instance = Dio();
  instance.options.connectTimeout = const Duration(seconds: 5);
  instance.options.receiveTimeout = const Duration(seconds: 3);
  instance.options.responseType = ResponseType.json;

  instance.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        if (token.value != null) {
          options.headers['Authorization'] =
              'Bearer ${token.value!.accessToken}';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await ref.read(tokensNotifierProvider.notifier).refresh();
        }
        return handler.next(error);
      },
    ),
  );

  // TODO: Remove this interceptor in production
  instance.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));

  return instance;
});
