import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer<Cart>(
              builder: (context, cart, _) {
                return ListView.builder(
                  itemCount: cart.count,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text('x${cart.qtyOf(cart.items[index])}'),
                      title: Text(cart.items[index].title),
                      subtitle: Text(cart.items[index].author),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.plus_one),
                            onPressed: () => cart.increment(cart.items[index]),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => cart.remove(cart.items[index]),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Consumer<Cart>(
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  Text('Total: '),
                ],
              ),
              builder: (context, cart, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    child!,
                    Text('${cart.total} KZT')
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}