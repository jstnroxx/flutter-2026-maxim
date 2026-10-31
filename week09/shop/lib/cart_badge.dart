import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final int count = context.watch<Cart>().count;
    final int total = context.watch<Cart>().total;

    return Badge(
      label: Text('$count items, $total KZT'),
      child: IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () => Navigator.of(context).pushNamed('/cart'),
      ),
    );
  }
}