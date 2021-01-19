import 'package:flutter/material.dart';
import 'package:crudapi/apiservice.dart';
import 'package:crudapi/view/HomePage.dart';
import 'package:crudapi/view/FormAddBook.dart';
import 'package:flutter/material.dart';
import 'package:crudapi/model/Book.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MainApps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter CRUD API'),
        routes: <String, WidgetBuilder> {
          "start" : (BuildContext context) => new MyApp(),
        }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiService apiService;
  HomePage _homePage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiService = ApiService();
    _homePage = new HomePage(apiService: apiService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          "Flutter CRUD API",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              var result = await Navigator.push(
                _scaffoldState.currentContext,
                MaterialPageRoute(builder: (BuildContext context) {
                  return FormAddBook(book: null) ;
                }),
              );
              if (result != null) {
                setState(() {});
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _homePage.createViewList(),//HomeScreen()
    );
  }

}
