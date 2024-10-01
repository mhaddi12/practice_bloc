import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practice_bloc/data/cart_list.dart';
import 'package:practice_bloc/data/home_products_list.dart';
import 'package:practice_bloc/data/wishliat_list.dart';
import 'package:practice_bloc/features/home/models/home_product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<InitialFetchEvent>(initialFetchState);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonClickedEvent>(homeWishlistButtonClickedEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
  }

  FutureOr<void> initialFetchState(
      InitialFetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        productDataModel: ProductData.products
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                quantity: e['quantity'],
                category: e['category'],
                imageUrl: e['image_url']))
            .toList()));
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Cart clicked");
    cartList.add(event.clickedProduct);
    emit(HomeProductsCartedActionState());
  }

  FutureOr<void> homeWishlistButtonClickedEvent(
      HomeWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    // final clickedProduct = event.clickedProduct;
    // clickedProduct. = !clickedProduct.isWishlisted;
    print("Wishlist clicked");
    wishListItem.add(event.clickedProduct);
    print(wishListItem);
    emit(HomeProductsWishlistedActionState());
    // emit(HomeIconColorChangeState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Cart Navigate clicked");
    emit(HomeNavigatToCartPageActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Wishlist Navigate clicked");
    emit(HomeNavigateToWishlistPageActionState());
  }
}
