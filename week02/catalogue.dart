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
}