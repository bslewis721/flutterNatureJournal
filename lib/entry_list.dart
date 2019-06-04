import 'dart:math';

import 'package:flutter/material.dart';

import 'entry_card.dart';
import 'entry_model.dart';

class EntryList extends StatelessWidget {
  final AsyncSnapshot<List<Entry>> entries;
  EntryList(this.entries);

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  String randomString(int length) {
    var rand = Random();
    var codeUnits = List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });
    return new String.fromCharCodes(codeUnits);
  }

  ListView _buildList(context) {
    entries.data.sort();
    return ListView.builder(
      key: Key(randomString(20)),
      itemCount: entries.data.length,
      itemBuilder: (context, int) {
        return EntryCard(entries.data[int]);
      },
    );
  }
}
