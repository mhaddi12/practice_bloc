part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitialFetchState extends HomeEvent {}

//click

class HomeProductCartButtonClickedEvent extends HomeEvent {}

class HomeWishlistButtonClickedEvent extends HomeEvent {}

//navigate

class HomeCartButtonNavigateEvent extends HomeEvent {}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}
