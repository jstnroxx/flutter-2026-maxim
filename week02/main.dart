import 'data.dart';
import 'models.dart';
import 'catalogue.dart';
import 'shelf_state.dart';

void main() {
  final Library someLib = Library(items: rawBooks.map((rawBook) => Book.fromJson(rawBook)).toList());

  print(someLib.allTitles);
  print(someLib.recentBooks);
  print(someLib.averagePages);
  print(someLib.authorStats);
  print(someLib.distinctAuthors);
  print(someLib.genresPresent);
  print(someLib.catalogueInfo);

  print(statsOf(someLib.items.whereType<Book>().toList()));
  
  print(describe(Empty()));
  print(describe(Ready(books: someLib.items.whereType<Book>().toList())));
  print(describe(Broken(message: 'Some error occurred.')));
}
