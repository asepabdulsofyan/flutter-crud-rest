import 'package:crudapi/model/Book.dart';
import 'package:http/http.dart' show Client;
//import 'dart:convert';

class ApiService {
  final String baseUrl = "localhost:8080";
  Client client = Client();

  Future<BookResult> getBooks() async {
    final response = await client.get(new Uri.http("$baseUrl", "/books/"));
    if (response.statusCode == 200) {
      return booksResultFromJson(response.body);
    } else {
      return new BookResult();
    }
  }

  Future<bool> createBook(Book data) async {
    final response = await client.post(
      new Uri.http("$baseUrl", "/books/"),
      headers: {"content-type": "application/json"},
      body: bookToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateBook(Book data) async {
    final response = await client.put(
      new Uri.http("$baseUrl", "/books/${data.book_id}"),
      headers: {"content-type": "application/json"},
      body: bookToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteBook(int id) async {
    final response = await client.delete(
      new Uri.http("$baseUrl", "/books/$id"),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
