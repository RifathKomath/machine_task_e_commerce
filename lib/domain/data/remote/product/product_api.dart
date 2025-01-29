
import 'package:dio/dio.dart';
import 'package:e_commerce/domain/model/product_model.dart';
import '../../../../core/config/constants/constants.dart';
import '../../../../core/network/dio_client.dart';


class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  // Get product//
  Future<List<ProductModel>> fetchProduct() async {
    try {
      final response = await _dioClient.get(ApiUrl.endPoint);
      return (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to load users: ${e.message}");
    }
  }

 
}
