import 'package:gifthub/layer/domain/entity/voucher.entity.dart';
import 'package:gifthub/layer/domain/repository/product.repository.dart';
import 'package:gifthub/layer/domain/repository/voucher.repository.dart';

class GetAllVouchers {
  GetAllVouchers({
    required VoucherRepositoryMixin voucherRepository,
    required ProductRepositoryMixin productRepository,
  })  : _voucherRepository = voucherRepository,
        _productRepository = productRepository;

  final VoucherRepositoryMixin _voucherRepository;
  final ProductRepositoryMixin _productRepository;

  Future<List<Voucher>> call() async {
    final ids = await _voucherRepository.getVoucherIds();
    final list = await Future.wait(
      ids.map(
        (id) => _voucherRepository.getVoucher(id: id),
      ),
    );
    final vouchers = await Future.wait(
      list.map(
        (voucher) async {
          final product =
              await _productRepository.getProduct(id: voucher.productId);
          voucher.imageUrl = product.imageUrl;
          voucher.name = product.name;
          voucher.price = product.price;
          return voucher;
        },
      ),
    );
    return vouchers;
  }
}
