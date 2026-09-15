import 'models.dart';

class Library {
  final List<LibraryItem> items;
  late final DateTime openedAt;
  String? _cachedReport;

  Library({required this.items});

  void add(LibraryItem item) {
    items.add(item);
  }

  Book? findByTitle(String title) {
    for (final item in items) {
      if (item is Book && item.title == title) {
        return item;
      }
    }

    return null;
  }

  String countryOf(String title) {
    return findByTitle(title)?.author.country ?? 'unknown';
  }

  void open() => openedAt = DateTime.now();

  String? buildReport() {
    _cachedReport ??= 'Library opened at $openedAt with ${items.length} items initially.';

    return _cachedReport;
  }

  List<String> get allTitles => items.map((item) => item.title).toList();

  List<Book> get recentBooks => items.whereType<Book>().where((book) => book.year > 2010).toList();

  int get averagePages => (items.whereType<Book>().length > 0) ? (items.whereType<Book>().fold(0, (totalPages, book) => totalPages + book.pages) ~/ items.whereType<Book>().length) : 0;
  // We don't use reduce here because we need to have initial value specified as 0 in order to accumulate pages.

  Map<String, int> get authorStats => items.whereType<Book>().fold(<String, int>{}, (stats, book) => stats..[book.author.name] = (stats[book.author.name] ?? 0) + 1);

  Set<String> get distinctAuthors => items.whereType<Book>().map((book) => book.author.name).toSet();

  Set<Genre> get genresPresent => items.whereType<Book>().map((book) => book.genre).toSet();

  List<String> get catalogueInfo => ['CATALOGUE', for (final book in items.whereType<Book>()) '${book.title} (${book.year})', ...items.whereType<Book>().map((book) => book.author.name).toSet(), if (items.whereType<Book>().any((book) => book.pages == 0)) '(incomplete data)'];
}