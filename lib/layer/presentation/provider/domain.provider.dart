// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/layer/domain/usecase/get_all_vouchers.usecase.dart';
import 'package:gifthub/layer/domain/usecase/get_product.usecase.dart';
import 'package:gifthub/layer/domain/usecase/sign_in.usecase.dart';
import 'package:gifthub/layer/domain/usecase/sign_up.usecase.dart';
import 'package:gifthub/layer/presentation/provider/data.provider.dart';

final getAllVouchersProvider = Provider(
  (ref) => GetAllVouchers(
    voucherRepository: ref.read(voucherRepositoryProvider),
    productRepository: ref.read(productRepositoryProvider),
  ),
);

final getProductProvider = Provider(
  (ref) => GetProduct(
    repository: ref.read(productRepositoryProvider),
  ),
);

final signInProvider = Provider(
  (ref) => SignIn(
    repository: ref.read(tokenRepositoryProvider),
  ),
);

final signUpProvider = Provider(
  (ref) => SignUp(
    repository: ref.read(tokenRepositoryProvider),
  ),
);
