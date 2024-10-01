part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishlistInitailFetchEvent extends WishlistEvent {
}

class WishlistRemoveFromWishlistEvent extends WishlistEvent {
  final int id;

  WishlistRemoveFromWishlistEvent({required this.id});
}
