import 'package:equatable/equatable.dart';
import '../../../../domain/model/product_model.dart';


class CartState extends Equatable {
  final List<ProductModel> cartItems;

  CartState({required this.cartItems});

  @override
  List<Object?> get props => [cartItems];
}
