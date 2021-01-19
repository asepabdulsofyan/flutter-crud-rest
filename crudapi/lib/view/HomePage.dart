import 'package:crudapi/view/FormAddBook.dart';
import 'package:flutter/material.dart';
import 'package:crudapi/model/Book.dart';
import 'package:crudapi/apiservice.dart';

class HomePage {
  ApiService apiService;
  HomePage({this.apiService});

  Widget createViewList(){
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getBooks(),
        builder: (BuildContext context, AsyncSnapshot<BookResult> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Book> books = snapshot.data.data;
            return buildListBook(books) ;
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildListBook(List<Book> listbook) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Book book = listbook[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(book.author),
                    Text(book.sinopsis),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              apiService.deleteBook(book.book_id).then((value) =>
                                  Navigator.of(context).pushNamed("start")
                              );
                            },
                            child: Text("Delete", style: TextStyle(color: Colors.red),
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return FormAddBook(book: book);
                              }));
                            },
                            child: Text("Edit", style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ]
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: listbook.length,
      ),
    );
  }
}