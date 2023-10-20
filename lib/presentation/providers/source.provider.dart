// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:gifthub/data/repositories/auth.repository.dart';
import 'package:gifthub/data/repositories/brand.repository.dart';
import 'package:gifthub/data/repositories/notification.repository.dart';
import 'package:gifthub/data/repositories/product.repository.dart';
import 'package:gifthub/data/repositories/token.repository.dart';
import 'package:gifthub/data/repositories/user.repository.dart';
import 'package:gifthub/data/repositories/voucher.repository.dart';
import 'package:gifthub/data/sources/auth.api.dart';
import 'package:gifthub/data/sources/auth.sdk.dart';
import 'package:gifthub/data/sources/brand.api.dart';
import 'package:gifthub/data/sources/notification.api.dart';
import 'package:gifthub/data/sources/product.api.dart';
import 'package:gifthub/data/sources/token.storage.dart';
import 'package:gifthub/data/sources/user.api.dart';
import 'package:gifthub/data/sources/voucher.api.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/brand.repository.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';
import 'package:gifthub/domain/repositories/product.repository.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

///SECTION - Repositories

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(
    notificationApi: ref.watch(notificationApiProvider),
  );
});

final voucherRepositoryProvider = Provider<VoucherRepository>((ref) {
  final voucherApi = ref.watch(voucherApiProvider);
  return VoucherRepositoryImpl(voucherApi);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    authApi: ref.watch(authApiProvider),
    authSdk: ref.watch(authSdkProvider),
  );
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(
    userApi: ref.watch(userApiProvider),
  );
});

final brandRepositoryProvider = Provider<BrandRepository>((ref) {
  return BrandRepositoryImpl(
    brandApi: ref.watch(brandApiProvider),
  );
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    productApi: ref.watch(productApiProvider),
  );
});

final tokenRepositoryProvider = Provider<TokenRepository>((ref) {
  return TokenRepositoryImpl(
    tokenStorage: ref.watch(tokenStorageProvider),
  );
});

///!SECTION - Repositories
///SECTION - APIs

final notificationApiProvider = Provider<NotificationApi>((ref) {
  final dio = ref.watch(dioProvider);
  return NotificationApi(dio);
});

final voucherApiProvider = Provider<VoucherApi>((ref) {
  final dio = ref.watch(dioProvider);
  return VoucherApi(dio);
});

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthApi(dio);
});

final userApiProvider = Provider<UserApi>((ref) {
  final dio = ref.watch(dioProvider);
  return UserApi(dio);
});

final brandApiProvider = Provider<BrandApi>((ref) {
  final dio = ref.watch(dioProvider);
  return BrandApi(dio);
});

final productApiProvider = Provider<ProductApi>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductApi(dio);
});

///!SECTION - APIs
///SECTION - SDKs

final authSdkProvider = Provider<AuthSdk>((ref) {
  return AuthSdk();
});

///!SECTION - SDKs
///SECTION - Storages

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final flutterSecureStorage = ref.watch(flutterSecureStorageProvider);
  return TokenStorage(flutterSecureStorage);
});

///!SECTION - Storages
///SECTION - Others

final authTokenProvider = StateProvider<AuthToken?>((ref) {
  return null;
});

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final dioProvider = Provider<Dio>((ref) {
  const host = 'https://api.dev.gifthub.kr';
  final authToken = ref.watch(authTokenProvider);
  return Dio(
    BaseOptions(
      baseUrl: host,
      headers: {
        'User-Agent': 'GiftHub/0.3.2',
        'Content-Type': 'application/json',
        if (authToken != null)
          'Authorization': 'Bearer ${authToken.accessToken}',
      },
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            if (authToken != null &&
                authToken.isStaled &&
                authToken.isExpired == false) {
              final response = await Dio().post(
                '$host/auth/refresh',
                options: Options(
                  headers: {
                    'Authorization': 'Bearer ${authToken.refreshToken}',
                  },
                ),
              );
              // ignore: avoid_dynamic_calls
              final newToken = AuthToken.fromJson(response.data['data']);
              ref.watch(authTokenProvider.notifier).state = newToken;
              options.headers['Authorization'] =
                  'Bearer ${newToken.accessToken}';
              return handler.next(options);
            }
            return handler.next(options);
          } catch (error) {
            if (error is DioException) {
              return handler.reject(UnauthorizedException.from(error));
            }
            rethrow;
          }
        },
        onResponse: (response, handler) {
          if (response.statusCode == 200) {
            final data = response.data as Map<String, dynamic>?;
            if (data != null && data.containsKey('data')) {
              response.data = data['data'];
            }
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            return handler.next(
              UnauthorizedException.from(error),
            );
          }
          return handler.next(error);
        },
      ),
    );
});

final firebaseAnalyticsProvider = Provider<FirebaseAnalytics>((ref) {
  return FirebaseAnalytics.instance;
});

///!SECTION - Others