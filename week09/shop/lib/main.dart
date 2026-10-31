import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'books_screen.dart';
import 'cart_screen.dart';
import 'models/cart.dart';

void main() {
  return runApp(
    ChangeNotifierProvider(create: (_) => Cart(), child: const Shell()),
  );
}

// Level 1: the owner of the cart. It sits ABOVE MaterialApp
// so that both routes can see the same list.

class Shell extends StatelessWidget {
  const Shell({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      routes: {'/': (_) => BooksScreen(), '/cart': (_) => CartScreen()},
    );
  }
}
