class Author {
  final String name;
  final String? country;

  const Author({required this.name, this.country});

  @override
  String toString() => 'Author($name${country != null ? ", $country" : ""})';
}

enum Genre {
  craft('Craft & Practice'),
  theory('Theory'),
  unknown('Unknown');

  final String label;
  const Genre(this.label);

  static Genre fromString(String? raw) {
    return Genre.values.firstWhere(
            (genre) => genre.name == raw,
            orElse: () => Genre.unknown,
    );
  }
}

abstract class LibraryItem {
  final String title;
  final int year;

  const LibraryItem({required this.title, required this.year});

  String describe();

  bool get isOld => year < 2010;
}

mixin Borrowable on LibraryItem {
  String borrowLabel() {
    return 'Borrowing $title.';
  }
}

class Book extends LibraryItem with Borrowable {
  final int pages;
  final Author author;
  final Genre genre;
  final String? description;

  const Book({
    required super.title,
    required super.year,
    required this.pages,
    required this.author,
    required this.genre,
    this.description
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String,
      year: json['year'] as int,
      pages: (json['pages'] ?? 0) as int,
      author: Author(
        name: json['author'] as String,
        country: json['country'] as String?,
      ),
      genre: Genre.fromString(json['genre'] as String?),
      description: json['description'] as String?,
    );
  }

  bool get isLong => pages > 400;

  Book copyWith({
    String? title,
    int? year,
    int? pages,
    Author? author,
    Genre? genre,
    String? description,
  }) {
    return Book(
      title: title ?? this.title,
      year: year ?? this.year,
      pages: pages ?? this.pages,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
    );
  }

  @override
  String toString() => 'Book($title, $year, $pages, $author, ${genre.label}${description != null ? ", $description" : ""})';

  @override
  String describe() {
    return '"$title" of ${genre.label} genre written by $author in $year has $pages pages.';
  }
}

class Magazine extends LibraryItem {
  final int issue;

  const Magazine({required super.title, required super.year, required this.issue});

  @override
  String describe() {
    return 'The "$title"\'s issue is $issue.';
  }
}

class Ghost implements LibraryItem {
  @override
  final String title;

  @override
  final int year;

  const Ghost({required this.title, required this.year});

  @override
  String describe() => 'The "$title" is a ghost library item.';

  @override
  bool get isOld => year < 2020;
}