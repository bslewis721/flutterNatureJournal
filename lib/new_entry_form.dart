import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

import 'entry_model.dart';

class AddEntryFormPage extends StatefulWidget {
  @override
  _AddEntryFormPageState createState() => _AddEntryFormPageState();
}

class _AddEntryFormPageState extends State<AddEntryFormPage> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String _imageFile;
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void submissionError(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(message),
    ));
  }

  void submitEntry(BuildContext context) {
    if (titleController.text.isEmpty) {
      submissionError(context, 'We need a title!');
    } else if (titleController.text.length > 20) {
      submissionError(context, 'We need a bit of a shorter title!');
    } else if (locationController.text.isEmpty) {
      submissionError(context, 'We need a location');
    } else if (locationController.text.length > 25) {
      submissionError(context, 'Try abbreviating the location!');
    } else if (descriptionController.text.isEmpty) {
      submissionError(context, 'You didn\'t say anything about this event.');
    } else if (descriptionController.text.length > 475) {
      submissionError(context, 'Try making your entry more concise.');
    } else if (_imageFile == null) {
      submissionError(context, 'We need an image for your post');
    } else {
      var newEntry = Entry(
        titleController.text,
        locationController.text,
        descriptionController.text,
        _date,
        _time,
        _imageFile,
      );
      Navigator.of(context).pop(newEntry);
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2018),
        lastDate: DateTime(2022));

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
      print('Date selected: ${_date.toString()}');
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
      print('Time selected: ${_time.toString()}');
    }
  }

  Future getImageFromCam() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFile = image.path;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.black87,
          displayColor: Colors.black87,
          fontFamily: 'Cabin',
        );

    return Scaffold(
      backgroundColor: Colors.orange[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          'New Entry',
          style: newTextTheme.title,
        ),
        backgroundColor: Colors.orangeAccent[200],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.lightBlue[400],
                  onPressed: getImageFromGallery,
                  tooltip: 'Pick Image',
                  child: Icon(
                    Icons.wallpaper,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: titleController,
                      onSubmitted: (text) => titleController.text = text,
                      style: newTextTheme.subhead,
                      cursorColor: Colors.black87,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'What happened?',
                        labelStyle: newTextTheme.subhead,
                        hintStyle: newTextTheme.subhead,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: locationController,
                    onSubmitted: (text) => locationController.text = text,
                    style: newTextTheme.subhead,
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      hintText: 'Where did this happen?',
                      labelStyle: newTextTheme.subhead,
                      hintStyle: newTextTheme.subhead,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    maxLines: 4,
                    controller: descriptionController,
                    onSubmitted: (text) => descriptionController.text = text,
                    style: newTextTheme.subhead,
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                      labelText: 'Details',
                      hintText: 'Write some details about your entry',
                      labelStyle: newTextTheme.subhead,
                      hintStyle: newTextTheme.subhead,
                    ),
                  ),
                  //),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 32.0),
                  child: Row(
                    children: <Widget>[
                      RaisedButton.icon(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.black87,
                        ),
                        label: Text(
                          'Select Date',
                          style: newTextTheme.subhead,
                        ),
                        onPressed: () {
                          _selectDate(context);
                        },
                        color: Colors.lightBlue[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: RaisedButton.icon(
                          icon: Icon(
                            Icons.access_time,
                            color: Colors.black87,
                          ),
                          label: Text(
                            'Select Time',
                            style: newTextTheme.subhead,
                          ),
                          onPressed: () {
                            _selectTime(context);
                          },
                          color: Colors.lightBlue[400],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(
                    builder: (BuildContext context) {
                      return RaisedButton(
                        onPressed: () => submitEntry(context),
                        color: Colors.indigo[300],
                        child: Text(
                          'Add Entry',
                          style: newTextTheme.subhead,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
