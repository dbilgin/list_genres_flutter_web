import 'package:flutter_web/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(GenresWebApp());

/// This Widget is the main application widget.
class GenresWebApp extends StatelessWidget {
  static const String _title = 'Flutter Web App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: GenresWebStatefulWidget(),
    );
  }
}

class GenresWebStatefulWidget extends StatefulWidget {
  GenresWebStatefulWidget({Key key}) : super(key: key);

  @override
  _GenresWebStatefulWidgetState createState() => _GenresWebStatefulWidgetState();
}

class _GenresWebStatefulWidgetState extends State<GenresWebStatefulWidget> {

  List<Card> _listWidget = new List<Card>();

  Future<List<dynamic>> getMovieGenres() async {
    return json.decode((await http.get(
            'assets/genres.json'))
        .body) as List;
  }
  Future getGenres() async {
    List<Card> listWidget = new List<Card>();

    List<dynamic> list = await getMovieGenres();
    for(dynamic obj in list) {
      listWidget.add(
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(obj["name"], style: TextStyle(fontSize: 22.0),),
          )
        )
      );
    }

    setState(() {
      _listWidget = listWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Web App'),
            backgroundColor: Colors.red,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.movie)),
                Tab(icon: Icon(Icons.help)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Get List'),
                    onPressed: () {
                      getGenres();
                    },
                  ),
                  Expanded(
                    child: ListView(
                      children: _listWidget,
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  'This is an example app with Tabs and ListView. Click the "Get List" button to get the list of genres on the first tab.'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
