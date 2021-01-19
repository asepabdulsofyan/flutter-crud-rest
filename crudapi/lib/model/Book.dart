import 'dart:convert';

class Book {
  int book_id;
  String title;
  String author;
  String sinopsis;
  String cover;

  Book(
      {this.book_id = 0,
      this.title,
      this.author,
      this.sinopsis,
      this.cover = "cover_default.jpg"});

  factory Book.fromJson(Map<String, dynamic> map) {
    return Book(
        book_id: map["book_id"],
        title: map["title"],
        author: map["author"],
        sinopsis: map["sinopsis"],
        cover: map["cover"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "": book_id,
      "title": title,
      "author": author,
      "sinopsis": sinopsis,
      "cover": cover
    };
  }

  @override
  String toString() {
    return 'Book{book_id: $book_id,title: $title, author: $author, sinopsis: $sinopsis, cover: $cover}';
  }
}

class BookResult {
  String status;
  List<Book> data = new List<Book>();
  BookResult({this.status, this.data});
  factory BookResult.fromJson(Map<String, dynamic> data) {
    return BookResult(
        status: data["status"],
        data: List<Book>.from(data["data"].map((item) => Book.fromJson(item))));
  }
}

// function external class
BookResult booksResultFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return BookResult.fromJson(data);
}

String bookToJson(Book book) {
  final jsonData = book.toJson();
  return json.encode(jsonData);
}
