part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitialFetchEvent extends HomeEvent {}

//click

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class HomeWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeWishlistButtonClickedEvent({required this.clickedProduct});
}

//navigate

class HomeCartButtonNavigateEvent extends HomeEvent {}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}
