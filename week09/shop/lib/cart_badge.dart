import 'package:flutter/material.dart';

class CartBadge extends StatelessWidget {
  final int count;
  final int total;

  const CartBadge({super.key, required this.count, required this.total});

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text('$count items, $total KZT'),
      child: IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () => Navigator.of(context).pushNamed('/cart'),
      ),
    );
  }
}