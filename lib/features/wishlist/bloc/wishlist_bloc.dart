import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practice_bloc/data/wishliat_list.dart';
import 'package:practice_bloc/features/home/models/home_product_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitailFetchEvent>(wishlistInitailFetchEvent);
    on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);
  }

  FutureOr<void> wishlistInitailFetchEvent(
      WishlistInitailFetchEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlist: wishListItem));
  }

  FutureOr<void> wishlistRemoveFromWishlistEvent(
      WishlistRemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
    wishListItem.removeWhere((item) => item.id == event.id);
    emit(WishlistRemoveState());
    emit(WishlistSuccessState(wishlist: wishListItem));
  }
}
