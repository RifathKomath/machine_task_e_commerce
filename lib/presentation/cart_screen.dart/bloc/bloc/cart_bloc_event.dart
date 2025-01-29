import 'package:equatable/equatable.dart';
import '../../../../domain/model/product_model.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final ProductModel product;

  AddToCartEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final ProductModel product;

  RemoveFromCartEvent({required this.product});

  @override
  List<Object?> get props => [product];
}
