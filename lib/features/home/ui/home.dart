import 'package:flutter/material.dart';
import 'package:practice_bloc/features/cart/ui/cart.dart';
import 'package:practice_bloc/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_bloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homebloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homebloc,
      listener: (context, state) {
        if (state is HomeNavigatToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context, MaterialPageRoute(builder:(_)=> const WishList()));
        }
      },
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Haddi Product App"),
            actions: [
              IconButton(
                  onPressed: () {
                    homebloc.add(HomeCartButtonNavigateEvent());
                  },
                  icon: const Icon(Icons.favorite_border)),
              IconButton(
                  onPressed: () {
                    homebloc.add(HomeWishlistButtonNavigateEvent());
                  },
                  icon: const Icon(Icons.shopping_cart)),
            ],
          ),
        );
      },
    );
  }
}
