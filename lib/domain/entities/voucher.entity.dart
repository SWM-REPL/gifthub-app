// 📦 Package imports:
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:gifthub/utility/format_string.dart';

class Voucher with EquatableMixin {
  final int id;
  final int productId;
  final String barcode;
  final DateTime expiresAt;
  final int? price;
  final int? _balance;
  final String? imageUrl;

  Voucher({
    required this.id,
    required this.productId,
    required this.barcode,
    required this.expiresAt,
    required this.price,
    this.imageUrl,
    int? balance,
  }) : _balance = balance;

  int get remainDays {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return expiresAt.difference(today).inDays;
  }

  int get balance => _balance ?? 0;
  bool get isUsable =>
      balance > 0 &&
      expiresAt.isAfter(DateTime.now().subtract(const Duration(days: 1)));
  bool get isExpired => remainDays < 0;
  bool get aboutToExpire => !isExpired && remainDays < 7;

  String get balanceFormatted => currencyFormat(balance);
  String get expiresAtFormatted {
    final difference = expiresAt.difference(DateTime.now());
    if (difference.inDays < 0) {
      return '만료됨';
    } else if (difference.inDays == 0) {
      return '오늘 만료';
    } else if (difference.inDays == 1) {
      return '내일 만료';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}일 남음';
    } else if (difference.inDays < 365) {
      return '${difference.inDays ~/ 30}개월 남음';
    } else {
      return '${difference.inDays ~/ 365}년 남음';
    }
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        barcode,
        expiresAt,
        price,
        balance,
        imageUrl,
      ];
}
