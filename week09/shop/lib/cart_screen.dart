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
                      title: Text(cart.items[index].title),
                      subtitle: Text(cart.items[index].author),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => cart.remove(cart.items[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child:  Text('${context.watch<Cart>().total} KZT'),
          ),
        ],
      ),
    );
  }
}