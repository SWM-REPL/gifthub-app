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
import 'package:gifthub/data/sources/token.sdk.dart';
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

///SECTION - Constants

const _apiHost = 'https://api.dev.gifthub.kr';
const _appVersion = '0.4.1';
const host = 'https://gifthub.kr';
final contactUsUri = Uri.parse('https://google.com');

///!SECTION - Constants
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
    authSdk: ref.watch(authSdkProvider),
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
    tokenSdk: ref.watch(tokenSdkProvider),
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
  return AuthApi(
    host: _apiHost,
    userAgent: 'GiftHub/$_appVersion',
  );
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

final tokenSdkProvider = Provider<TokenSdk>((ref) {
  return TokenSdk();
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
  final authToken = ref.watch(authTokenProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  final tokenRepository = ref.watch(tokenRepositoryProvider);
  return Dio(
    BaseOptions(
      baseUrl: _apiHost,
      headers: {
        'User-Agent': 'GiftHub/$_appVersion',
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
              final newToken = await authRepository.refreshAuthToken(
                refreshToken: authToken.refreshToken,
                deviceToken: await tokenRepository.getDeviceToken(),
                fcmToken: await tokenRepository.getFcmToken(),
              );
              tokenRepository.saveAuthToken(newToken);
              ref.watch(authTokenProvider.notifier).state = newToken;
              options.headers['Authorization'] =
                  'Bearer ${newToken.accessToken}';
              return handler.next(options);
            }
            return handler.next(options);
          } catch (error) {
            if (error is DioException) {
              if (error.response?.statusCode == 401) {
                return handler.reject(UnauthorizedException.from(error));
              } else {
                return handler.reject(error);
              }
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