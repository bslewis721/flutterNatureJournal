import 'dart:io';

import 'package:flutter/material.dart';

import 'entry_detail_page.dart';
import 'entry_model.dart';
import 'package:intl/intl.dart';

class EntryCard extends StatefulWidget {
  final Entry entry;

  EntryCard(this.entry);

  @override
  _EntryCardState createState() => _EntryCardState(entry);
}

class _EntryCardState extends State<EntryCard> {
  Entry entry;
  String renderUrl;

  _EntryCardState(this.entry);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showEntryDetailPage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 50.0,
                child: entryCard,
              ),
              Positioned(top: 7.5, child: entryImage),
            ],
          ),
        ),
      ),
    );
  }

  Widget get entryCard {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
          fontFamily: 'Cabin',
        );

    return Container(
      width: 290.0,
      height: 115.0,
      child: Card(
        color: Colors.orangeAccent[100],
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 64.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                widget.entry.title,
                overflow: TextOverflow.ellipsis,
                style: newTextTheme.display1,
              ),
              Text(widget.entry.location, style: newTextTheme.subhead),
              Text(
                  "${widget.entry.date.day.toString()} ${DateFormat('MMMM').format(widget.entry.date)}, ${widget.entry.date.year.toString()}",
                  style: newTextTheme.subhead),
            ],
          ),
        ),
      ),
    );
  }

  Widget get entryImage {
    return Hero(
      tag: this.entry,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(File(widget.entry.imageFile) ?? null),
          ),
        ),
      ),
    );
  }

  showEntryDetailPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return EntryDetailPage(this.entry);
        },
      ),
    );
  }
}
