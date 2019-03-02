import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const appName = 'Meetee';

void main() {
  runApp(MaterialApp(
    title: appName,
    home: ChooseType(),
  ));
}

class ChooseType extends StatefulWidget {
  @override
  _ChooseTypeState createState() => _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose seat type')),
      body: ListView(
        children: <Widget>[
          ListTile(),
          ListTile(
            title: RaisedButton(
              child: Text('Single table'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChooseTime(seatType: 'Single table')),
                );
              },
            ),
          ),
          ListTile(
              title: RaisedButton(
            child: Text('Room type A'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChooseTime(seatType: 'Room type A')),
              );
            },
          ))
        ],
      ),
    );
  }
}

class ChooseTime extends StatefulWidget {
  final String seatType;
  ChooseTime({Key key, this.seatType}) : super(key: key);

  @override
  _ChooseTimeState createState() => _ChooseTimeState();
}

class _ChooseTimeState extends State<ChooseTime> {
  DateTime _date = DateTime.now();
  TimeOfDay _time_start = TimeOfDay.now();
  TimeOfDay _time_end = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2020));
    if (picked != null) {
      print('Selected date: ' + DateFormat('yyyy-MM-dd').format(_date));
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTimeStart(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time_start,
    );
    if (picked != null) {
      print('Selected date: ${_time_start.toString()}');
      setState(() {
        _time_start = picked;
      });
    }
  }

  Future<Null> _selectTimeEnd(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time_end,
    );
    if (picked != null) {
      print('Selected date: ${_time_end.toString()}');
      setState(() {
        _time_end = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date/Time'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Seat type: ${widget.seatType}'),
          ),
          ListTile(
            title:
                Text('Date select: ' + DateFormat('yyyy-MM-dd').format(_date)),
            subtitle: RaisedButton(
              child: Text('Select date'),
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
          ListTile(
            title: Text('Time select: ${_time_start.toString()}'),
            subtitle: RaisedButton(
              child: Text('Select time'),
              onPressed: () {
                _selectTimeStart(context);
              },
            ),
          ),
          ListTile(
            title: Text('Time select: ${_time_end.toString()}'),
            subtitle: RaisedButton(
              child: Text('Select time'),
              onPressed: () {
                _selectTimeEnd(context);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: RaisedButton(
        color: Colors.greenAccent,
        child: Text('Reserve !'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Summary(
                        seatType: '${widget.seatType}',
                        date: DateFormat('yyyy-MM-dd').format(_date),
                        time_start: '${_time_start.toString()}',
                        time_end: '${_time_end.toString()}',
                      )));
        },
      ),
    );
  }
}

class Summary extends StatefulWidget {
  final String seatType;
  final String date;
  final String time_start;
  final String time_end;

  const Summary(
      {Key key, this.seatType, this.date, this.time_start, this.time_end})
      : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  String name, gender;
  final String url = 'https://swapi.co/api/people/1';
  bool isData = false;

  Future _fetchJSON() async {
    var Response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );
    if (Response.statusCode == 200) {
      String responseBody = Response.body;
      var responseJSON = json.decode(responseBody);
      print(responseJSON);
      name = responseJSON['name'];
      gender = responseJSON['gender'];
      isData = true;
      setState(() {
        print(name);
      });
    } else {
      print('Something went wrong. \nResponse Code : ${Response.statusCode}');
    }
  }

  @override
  void initState() {
    _fetchJSON();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Seat type: ${widget.seatType}'),
          ),
          ListTile(
            title: Text('Date: ${widget.date}'),
          ),
          ListTile(
            title: Text('Time start: ${widget.time_start}'),
          ),
          ListTile(
            title: Text('Time end: ${widget.time_end}'),
          ),
          ListTile(
            title: Text('name: $name'),
            subtitle: Text('gender: $gender'),
          )
        ],
      ),
    );
  }
}
