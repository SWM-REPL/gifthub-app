// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:gifthub/data/dto/brand.dto.dart';

class BrandApi {
  final Dio dio;

  BrandApi(this.dio);

  Future<BrandDto> getBrandById(int id) async {
    final response = await dio.get('/brands/$id');
    return BrandDto.fromJson(response.data);
  }
}
