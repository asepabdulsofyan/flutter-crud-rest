import 'package:flutter/material.dart';
import 'package:crudapi/model/Book.dart';
import 'package:crudapi/apiservice.dart';

class FormAddBook extends StatefulWidget {
  Book book;
  FormAddBook({this.book});
  @override
  _FormAddBook createState() => _FormAddBook();
}

class _FormAddBook extends State<FormAddBook> {
  ApiService apiService;
  TextEditingController _contTitle = TextEditingController();
  TextEditingController _contAuthor = TextEditingController();
  TextEditingController _contSinopsis = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    if (widget.book != null) {
      _contTitle.text = widget.book.title;
      _contAuthor.text = widget.book.author;
      _contSinopsis.text = widget.book.sinopsis;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          widget.book == null ? "Add Book" : "Change Book",
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTextField(_contTitle, "Title"),
                  _buildTextField(_contAuthor, "Author"),
                  _buildTextField(_contSinopsis, "Sinopsis"),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: RaisedButton(
                      child: Text(widget.book == null ? "Add" : "Update"),
                      color: Colors.orange,
                      onPressed: () {
                        //onPres
                        int id = 0;
                        if (widget.book != null) {
                          id = widget.book.book_id;
                        }
                        Book book = Book(
                          book_id: id,
                          title: _contTitle.text.toString(),
                          author: _contAuthor.text.toString(),
                          sinopsis: _contSinopsis.text.toString(),
                        );
                        if (widget.book == null) {
                          apiService.createBook(book);
                        } else {
                          apiService.updateBook(book);
                        }
                        Navigator.of(context).pushNamed("start");
                      },
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController _cont, String label) {
    return TextField(
      controller: _cont,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
