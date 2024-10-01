part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistActionState extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishlist;

  WishlistSuccessState({required this.wishlist});
}

class WishlistRemoveState extends WishlistState {}

class WishlistIconColorChangeState extends WishlistState {}
