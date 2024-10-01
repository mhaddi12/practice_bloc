import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_bloc/data/wishliat_list.dart';

import 'package:practice_bloc/features/wishlist/bloc/wishlist_bloc.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final wishlist = WishlistBloc();
  @override
  void initState() {
    wishlist.add(WishlistInitailFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlist,
        listener: (context, state) {
          // Handle any Wishlist action events
        },
        buildWhen: (previous, current) => current is! WishlistActionState,
        listenWhen: (previous, current) => current is WishlistActionState,
        builder: (context, state) {
          if (state is WishlistSuccessState) {
            final success = state;

            return ListView.builder(
              itemCount: success.wishlist.length,
              itemBuilder: (context, index) {
                final item = state.wishlist[index];
                return Dismissible(
                  key: Key(item.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    // Handle removing the item from the wishlist
                    wishlist.add(WishlistRemoveFromWishlistEvent(id: item.id));
                  },
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '\$${item.price}',
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          wishlist.add(
                              WishlistRemoveFromWishlistEvent(id: item.id));
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
