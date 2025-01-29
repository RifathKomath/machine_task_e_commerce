import 'package:e_commerce/presentation/cart_screen.dart/bloc/bloc/cart_bloc_event.dart';
import 'package:e_commerce/presentation/cart_screen.dart/bloc/bloc/cart_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/model/product_model.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(cartItems: [])) {
    on<AddToCartEvent>((event, emit) {
      final updatedCart = List<ProductModel>.from(state.cartItems)..add(event.product);
      emit(CartState(cartItems: updatedCart));
    });

    on<RemoveFromCartEvent>((event, emit) {
      final updatedCart = List<ProductModel>.from(state.cartItems)..remove(event.product);
      emit(CartState(cartItems: updatedCart));
    });
  }
}
