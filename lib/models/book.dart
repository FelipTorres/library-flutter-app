class Book {
  final String title;
  final List<String> authors;
  final int? coverId;

  Book({required this.title, required this.authors, this.coverId});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Sem título',
      authors: (json['author_name'] as List<dynamic>?)?.map((a) => a as String).toList() ?? ['Autor desconhecido'],
      coverId: json['cover_i'],
    );
  }

  String get coverUrl => coverId != null
      ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
      : 'https://via.placeholder.com/100x150.png?text=Sem+Capa';
}