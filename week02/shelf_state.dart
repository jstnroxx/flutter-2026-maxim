import 'models.dart';

sealed class ShelfState {}

class Empty extends ShelfState {}

class Ready extends ShelfState {
  final List<Book> books;

  Ready({required this.books});
}

class Broken extends ShelfState {
  final String message;

  Broken({required this.message});
}

String describe(ShelfState state) {
  return switch (state) {
    Empty() => 'Empty.',
    Ready(books: final books) => 'Ready with ${books.length} books.',
    Broken(message: final message) => '$message',
  };
}

({int count, double avgPages}) statsOf(List<Book> books) {
  return (count: books.length, avgPages: books.length > 0 ? (books.fold(0, (totalPages, book) => totalPages + book.pages) / books.length) : 0);
}
