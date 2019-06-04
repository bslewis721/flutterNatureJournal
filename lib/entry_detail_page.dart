import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'entry_model.dart';
import 'entry_db.dart';

class EntryDetailPage extends StatefulWidget {
  final Entry entry;
  EntryDetailPage(this.entry);

  @override
  _EntryDetailPageState createState() => _EntryDetailPageState();
}

class _EntryDetailPageState extends State<EntryDetailPage> {
  final double entryAvatarSize = 175.0;

  void removeEntry(BuildContext context, Entry entry) {
    deleteEntry(entry.title);
    Navigator.of(context).pop();
  }

  Widget get entryImage {
    return Hero(
      tag: widget.entry,
      child: Container(
        height: entryAvatarSize,
        width: entryAvatarSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            const BoxShadow(
                offset: const Offset(1.0, 2.0),
                blurRadius: 2.0,
                spreadRadius: -1.0,
                color: const Color(0x33000000)),
            const BoxShadow(
                offset: const Offset(2.0, 1.0),
                blurRadius: 3.0,
                spreadRadius: 0.0,
                color: const Color(0x24000000)),
            const BoxShadow(
                offset: const Offset(3.0, 1.0),
                blurRadius: 4.0,
                spreadRadius: 2.0,
                color: const Color(0x1F000000)),
          ],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(File(widget.entry.imageFile) ?? null),
          ),
        ),
      ),
    );
  }

  Widget get entryProfile {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
          fontFamily: 'Cabin',
        );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.orange[400],
            Colors.orange[300],
            Colors.orange[200],
            Colors.orange[100],
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          entryImage,
          Text(
            widget.entry.title,
            style: newTextTheme.display2,
          ),
          Text(
            widget.entry.location,
            style: newTextTheme.headline,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Text(
              widget.entry.description,
              style: newTextTheme.subhead,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () => removeEntry(context, widget.entry),
                child: Icon(
                  Icons.delete_outline,
                  size: 40.0,
                ),
                backgroundColor: Colors.lightBlue[400],
              ),
            ],
          ),
          //rating
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
          fontFamily: 'Cabin',
        );

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        backgroundColor: Colors.orangeAccent[200],
        title: Text(
          "${widget.entry.time.hour}:${widget.entry.time.minute.toString().padLeft(2, '0')}, ${DateFormat.yMd().format(widget.entry.date)}",
          style: newTextTheme.title,
        ),
      ),
      body: entryProfile,
    );
  }
}
