part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoadingState extends HomeErrorState {
  
}

class HomeScreenLoadedSuccessState extends HomeScreenState {
  final List<ProductModel> products;
  HomeScreenLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeScreenState {}
