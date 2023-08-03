import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gifthub/apis/vouchers.api.dart';
import 'package:gifthub/providers/dio.provider.dart';
import 'package:gifthub/providers/product.provider.dart';

@immutable
class Voucher {
  final int id;
  final Product product;
  final String barcode;
  final DateTime expiredAt;

  const Voucher({
    required this.id,
    required this.product,
    required this.barcode,
    required this.expiredAt,
  });

  Voucher.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        product = Product.fromJson(json['product']),
        barcode = json['barcode'],
        expiredAt = DateTime.parse(json['expired_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'product': product.toJson(),
        'barcode': barcode,
        'expired_at': expiredAt.toIso8601String(),
      };
}

class VouchersNotifier extends AsyncNotifier<Map<int, Voucher>> {
  late final Dio _dio;

  @override
  Future<Map<int, Voucher>> build() async {
    _dio = ref.watch(dioProvider);
    return _load();
  }

  Future<Map<int, Voucher>> _load() async {
    final voucherIds = await VouchersApi.fetchVouchers(_dio);
    return {
      for (final id in voucherIds) id: await VouchersApi.fetchVoucher(_dio, id)
    };
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _load();
    });
  }
}

final vouchersNotifierProvider =
    AsyncNotifierProvider<VouchersNotifier, Map<int, Voucher>>(
  () => VouchersNotifier(),
);
