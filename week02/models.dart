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

class Book {
  final String title;
  final int year;
  final int pages;
  final Author author;
  final Genre genre;
  final String? description;

  const Book({
    required this.title,
    required this.year,
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
}