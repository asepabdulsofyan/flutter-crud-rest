import 'package:crudapi/model/Book.dart';
import 'package:http/http.dart' show Client;
//import 'dart:convert';

class ApiService {
  //jika pakai ios
  //final String baseUrl = "localhost:8080";
  //harap menjalankan rest dengan: php -S localhost:8080 -t public public/index.php
  //jika pakai android
  final String baseUrl = "10.0.2.2:8080";
  //harap menjalankan slimRest dengan: php -S 127.0.0.1:8080 -t public public/index.php
  Client client = Client();

  Future<BookResult> getBooks() async {
    String url = new Uri.http("$baseUrl", "/books/").toString();
    final response = await client.get(url);
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
