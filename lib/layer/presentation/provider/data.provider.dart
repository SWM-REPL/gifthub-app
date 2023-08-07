import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gifthub/layer/data/repository/product.repository.dart';
import 'package:gifthub/layer/data/repository/token.repository.dart';
import 'package:gifthub/layer/data/repository/voucher.repository.dart';
import 'package:gifthub/layer/data/source/local/token.storage.dart';
import 'package:gifthub/layer/data/source/network/product.api.dart';
import 'package:gifthub/layer/data/source/network/token.api.dart';
import 'package:gifthub/layer/data/source/network/voucher.api.dart';

final _productApiProvider = Provider<ProductApiMixin>((ref) => ProductApi());

final _tokenApiProvider = Provider<TokenApiMixin>((ref) => TokenApi());
final _tokenStorageProvider =
    Provider<TokenStorageMixin>((ref) => TokenStorage());

final _voucherApiProvider = Provider<VoucherApiMixin>((ref) => VoucherApi());

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepository(
    api: ref.read(_productApiProvider),
  ),
);

final tokenRepositoryProvider = Provider<TokenRepository>(
  (ref) => TokenRepository(
    api: ref.read(_tokenApiProvider),
    storage: ref.read(_tokenStorageProvider),
  ),
);

final voucherRepositoryProvider = Provider<VoucherRepository>(
  (ref) => VoucherRepository(
    api: ref.read(_voucherApiProvider),
  ),
);
