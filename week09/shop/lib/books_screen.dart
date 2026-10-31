import 'package:flutter/material.dart';
import 'main.dart';
import 'cart_badge.dart';

class BooksScreen extends StatelessWidget {
  final List<Book> cart;
  final int total;
  final void Function(Book) onAdd;

  const BooksScreen({super.key, required this.cart, required this.total, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    debugPrint('BooksScreen build');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CartBadge(count: cart.length, total: total),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          debugPrint('row ${books[index].title}');

          return ListTile(
            title: Text(books[index].title),
            subtitle: Text(books[index].author),
            trailing: cart.contains(books[index]) ?
              Text('Added') :
              OutlinedButton(onPressed: () => onAdd(books[index]), child: const Text('Add')),
          );
        },
      ),
    );
  }
}