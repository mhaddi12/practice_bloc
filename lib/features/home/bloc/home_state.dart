part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {}

class HomeErrorState extends HomeState {}

//actionState
class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigatToCartPageActionState extends HomeActionState {}
