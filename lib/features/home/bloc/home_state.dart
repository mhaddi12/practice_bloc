part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> productDataModel;
  HomeLoadedSuccessState({required this.productDataModel});
}

class HomeErrorState extends HomeState {}

//ActionState
class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigatToCartPageActionState extends HomeActionState {}
