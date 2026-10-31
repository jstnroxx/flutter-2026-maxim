import 'package:flutter/material.dart';
import 'main.dart';

class CartScreen extends StatelessWidget {
  final List<Book> items;
  final void Function(Book) onRemove;

  const CartScreen({super.key, required this.items, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index].title),
                  subtitle: Text(items[index].author),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => onRemove(items[index]),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child:  Text('${items.fold(0, (sum, book) => sum + book.price)} KZT'),
          ),
        ],
      ),
    );
  }
}