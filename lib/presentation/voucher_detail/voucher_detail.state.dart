// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/brand.entity.dart';
import 'package:gifthub/domain/entities/product.entity.dart';
import 'package:gifthub/domain/entities/voucher.entity.dart';

class VoucherDetailState with EquatableMixin {
  final Voucher voucher;
  final Product product;
  final Brand brand;

  const VoucherDetailState({
    required this.voucher,
    required this.product,
    required this.brand,
  });

  @override
  List<Object?> get props => [
        voucher,
        product,
        brand,
      ];
}
