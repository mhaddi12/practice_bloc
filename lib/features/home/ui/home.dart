import 'package:flutter/material.dart';
import 'package:practice_bloc/features/cart/ui/cart.dart';
import 'package:practice_bloc/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_bloc/features/home/models/home_product_model.dart';
import 'package:practice_bloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homebloc = HomeBloc();

  @override
  void initState() {
    homebloc.add(InitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listener: (context, state) {
        if (state is HomeNavigatToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const WishList()));
        } else if (state is HomeProductsCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Added item to Cart")));
        } else if (state is HomeProductsWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Added item to WishList")));
        }
      },
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text(
                  "Haddi Product App",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        homebloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        homebloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      )),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.productDataModel.length,
                itemBuilder: (context, index) {
                  final product = successState.productDataModel[index];
                  return ProductTitleWidgets(
                    product: product,
                    homeBloc: homebloc,
                  );
                },
              ),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text("Error: Data Not Found"),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}

class ProductTitleWidgets extends StatelessWidget {
  const ProductTitleWidgets({
    super.key,
    required this.product,
    required this.homeBloc,
  });

  final ProductDataModel product;
  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              product.imageUrl,
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price.toString()}",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonClickedEvent(
                          clickedProduct: product));
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: product.isWishlisted! ? Colors.red : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(
                          clickedProduct: product));
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
