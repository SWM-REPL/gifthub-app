// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// 🌎 Project imports:
import 'package:gifthub/data/repositories/auth.repository.dart';
import 'package:gifthub/data/repositories/brand.repository.dart';
import 'package:gifthub/data/repositories/notification.repository.dart';
import 'package:gifthub/data/repositories/product.repository.dart';
import 'package:gifthub/data/repositories/user.repository.dart';
import 'package:gifthub/data/repositories/voucher.repository.dart';
import 'package:gifthub/data/sources/auth.api.dart';
import 'package:gifthub/data/sources/auth.storage.dart';
import 'package:gifthub/data/sources/brand.api.dart';
import 'package:gifthub/data/sources/notification.api.dart';
import 'package:gifthub/data/sources/product.api.dart';
import 'package:gifthub/data/sources/user.api.dart';
import 'package:gifthub/data/sources/voucher.api.dart';
import 'package:gifthub/domain/entities/oauth_token.entity.dart';
import 'package:gifthub/domain/exceptions/unauthorized.exception.dart';
import 'package:gifthub/domain/repositories/auth.repository.dart';
import 'package:gifthub/domain/repositories/brand.repository.dart';
import 'package:gifthub/domain/repositories/notification.repository.dart';
import 'package:gifthub/domain/repositories/product.repository.dart';
import 'package:gifthub/domain/repositories/user.repository.dart';
import 'package:gifthub/domain/repositories/voucher.repository.dart';

///SECTION - Repositories

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final notificationApi = ref.watch(notificationApiProvider);
  return NotificationRepositoryImpl(notificationApi);
});

final voucherRepositoryProvider = Provider<VoucherRepository>((ref) {
  final voucherApi = ref.watch(voucherApiProvider);
  return VoucherRepositoryImpl(voucherApi);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    authStorage: ref.watch(authStorageProvider),
    authApi: ref.watch(authApiProvider),
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

///SECTION - Storages

final authStorageProvider = Provider<AuthStorage>((ref) {
  final flutterSecureStorage = ref.watch(flutterSecureStorageProvider);
  return AuthStorage(flutterSecureStorage);
});

///SECTION - Others

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final oauthTokenProvider = StateProvider<OAuthToken?>((ref) {
  return null;
});

final dioProvider = Provider<Dio>((ref) {
  final oauthToken = ref.watch(oauthTokenProvider);
  return Dio(
    BaseOptions(
      baseUrl: 'https://api.dev.gifthub.kr',
      headers: {
        'Content-Type': 'application/json',
        if (oauthToken != null)
          'Authorization': 'Bearer ${oauthToken.accessToken}',
      },
    ),
  )..interceptors.add(InterceptorsWrapper(
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
    ));
});
