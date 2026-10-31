import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_badge.dart';
import 'models/book.dart';
import 'models/cart.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('BooksScreen build');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(mainAxisSize: MainAxisSize.min, children: [CartBadge()]),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          debugPrint('row ${books[index].title}');

          return ListTile(
            title: Text(books[index].title),
            subtitle: Text(books[index].author),
            trailing: context.watch<Cart>().items.contains(books[index])
                ? Text('Added')
                : OutlinedButton(
                    onPressed: () {
                      final ok = context.read<Cart>().add(books[index]);

                      if (ok) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: const Text('Added')));
                      }
                    },
                    child: const Text('Add'),
                  ),
          );
        },
      ),
    );
  }
}
