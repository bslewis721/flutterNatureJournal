import 'package:flutter/material.dart';
import 'package:nature_journal/entry_db.dart';
import 'package:flutter/services.dart';

import 'entry_model.dart';
import 'entry_list.dart';
import 'new_entry_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your Field Journal',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: 'Journal Entries'),
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
  List<Entry> initialEntries = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
          fontFamily: 'Cabin',
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: newTextTheme.headline,
        ),
        backgroundColor: Colors.orangeAccent[200],
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black87,
            ),
            onPressed: _showNewEntryForm,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
              0.1,
              0.5,
              0.7,
              0.9
            ],
                colors: [
              Colors.orange[400],
              Colors.orange[300],
              Colors.orange[200],
              Colors.orange[100],
            ])),
        child: Center(
          child: FutureBuilder<List<Entry>>(
            future: entries(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? EntryList(snapshot)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }

  Future _showNewEntryForm() async {
    Entry newEntry = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return AddEntryFormPage();
        },
      ),
    );
    if (newEntry != null) {
      insertEntry(newEntry);
    }
  }
}
