import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_commerce/domain/data/repository/product/product_repositories.dart';
import 'package:e_commerce/domain/di/service_locator.dart';
import 'package:meta/meta.dart';
import '../../../../domain/model/product_model.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ProductRepository repo = getIt<ProductRepository>();
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<InitialFetchEvent>((event, emit) async {
      await homeInitialFetchEvent(emit);
    });
  }

  Future<void> homeInitialFetchEvent(Emitter<HomeScreenState> emit) async {
    emit(HomeScreenLoadingState());
    try {
      final products = await repo.getProduct();
      emit(HomeScreenLoadedSuccessState(products: products));
    } catch (error) {
      emit(HomeErrorState());
    }
  }
}
