import 'package:dio/dio.dart';
import 'package:e_commerce/domain/model/product_model.dart';

import '../../remote/product/product_api.dart';

class ProductRepository {
  final ApiService _apiService;
  ProductRepository(this._apiService);

  //get product
  Future<List<ProductModel>> getProduct() async {
    return await _apiService.fetchProduct();
  }
}
