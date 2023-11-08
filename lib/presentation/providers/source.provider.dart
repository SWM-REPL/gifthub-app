// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:gifthub/constants.dart';
import 'package:gifthub/data/repositories/auth.repository.dart';
import 'package:gifthub/data/repositories/brand.repository.dart';
import 'package:gifthub/data/repositories/giftcard.repository.dart';
import 'package:gifthub/data/repositories/notification.repository.dart';
import 'package:gifthub/data/repositories/product.repository.dart';
import 'package:gifthub/data/repositories/setting.repository.dart';
import 'package:gifthub/data/repositories/token.repository.dart';
import 'package:gifthub/data/repositories/user.repository.dart';
import 'package:gifthub/data/repositories/voucher.repository.dart';
import 'package:gifthub/data/sources/auth.api.dart';
import 'package:gifthub/data/sources/auth.sdk.dart';
import 'package:gifthub/data/sources/brand.api.dart';
import 'package:gifthub/data/sources/giftcard.api.dart';
import 'package:gifthub/data/sources/notification.api.dart';
import 'package:gifthub/data/sources/product.api.dart';
import 'package:gifthub/data/sources/setting.api.dart';
import 'package:gifthub/data/sources/setting.storage.dart';
import 'package:gifthub/data/sources/token.sdk.dart';
import 'package:gifthub/data/sources/token.storage.dart';
import 'package:gifthub/data/sources/user.api.dart';
import 'package:gifthub/data/sources/voucher.api.dart';
import 'package:gifthub/domain/entities/auth_token.entity.dart';
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/brand.repository.dart';
import 'package:gifthub/domain/repositories/giftcard.repository.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';
import 'package:gifthub/domain/repositories/product.repository.dart';
import 'package:gifthub/domain/repositories/setting.repository.dart';
import 'package:gifthub/domain/repositories/token.repository.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

///SECTION - Constants

final contactUsUri = Uri.parse(GiftHubConstants.contactUsUri);

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

final giftcardRepositoryProvider = Provider<GiftcardRepository>((ref) {
  return GiftcardRepositoryImpl(
    giftcardApi: ref.watch(giftcardApiProvider),
  );
});

final settingRepositoryProvider =
    FutureProvider<SettingRepository>((ref) async {
  return SettingRepositoryImpl(
    settingApi: ref.watch(settingApiProvider),
    settingStoreage: await ref.watch(settingStorageProvider.future),
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
    host: GiftHubConstants.apiHost,
    userAgent: 'GiftHub/${GiftHubConstants.appVersion}',
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

final giftcardApiProvider = Provider<GiftcardApi>((ref) {
  final dio = ref.watch(dioProvider);
  return GiftcardApi(dio);
});

final settingApiProvider = Provider<SettingApi>((ref) {
  final dio = ref.watch(dioProvider);
  return SettingApi(dio);
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

final settingStorageProvider = FutureProvider<SettingStorage>((ref) async {
  final settingPreference = await ref.watch(settingPreferenceProvider.future);
  return SettingStorage(settingPreference);
});

///!SECTION - Storages
///SECTION - Others

final authTokenProvider = StateProvider<AuthToken?>((ref) {
  return null;
});

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final settingPreferenceProvider =
    FutureProvider<SharedPreferences>((ref) async {
  final instance = await SharedPreferences.getInstance();
  await instance.reload();
  return instance;
});

final dioProvider = Provider<Dio>((ref) {
  final authToken = ref.watch(authTokenProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  final tokenRepository = ref.watch(tokenRepositoryProvider);
  return Dio(
    BaseOptions(
      baseUrl: GiftHubConstants.apiHost,
      headers: {
        'User-Agent': 'GiftHub/${GiftHubConstants.appVersion}',
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
