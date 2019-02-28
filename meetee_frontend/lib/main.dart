import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;

const appName = 'Meetee';

void main() {
  runApp(new MaterialApp(
    title: appName,
    home: ChooseType(),
  ));
}

class ChooseType extends StatefulWidget {
  @override
  _ChooseTypeState createState() => new _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Choose seat type')),
      body: new ListView(
        children: <Widget>[
          new ListTile(),
          new ListTile(
            title: new RaisedButton(
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
          new ListTile(
              title: new RaisedButton(
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
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2020));
    if (picked != null) {
      print('Selected date: ' + new DateFormat('yyyy-MM-dd').format(_date));
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null) {
      print('Selected date: ${_time.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Select Date/Time'),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('Seat type: ${widget.seatType}'),
          ),
          new ListTile(
            title: new Text(
                'Date select: ' + new DateFormat('yyyy-MM-dd').format(_date)),
            subtitle: new RaisedButton(
              child: new Text('Select date'),
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
          new ListTile(
            title: new Text('Date select: ${_time.toString()}'),
            subtitle: new RaisedButton(
              child: new Text('Select time'),
              onPressed: () {
                _selectTime(context);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: new RaisedButton(
        color: Colors.greenAccent,
        child: Text('Reserve !'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChooseSeat(
                        seatType: '${widget.seatType}',
                        date: new DateFormat('yyyy-MM-dd').format(_date),
                        time: '${_time.toString()}',
                      )));
        },
      ),
    );
  }

  void something() => {print('Something happen')};
}

class ChooseSeat extends StatefulWidget {
  final String seatType;
  final String date;
  final String time;
  ChooseSeat({Key key, this.seatType, this.date, this.time}) : super(key: key);

  @override
  _ChooseSeatState createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Result'),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('Seat type: ${widget.seatType}'),
          ),
          new ListTile(
            title: new Text('Date: ${widget.date}'),
          ),
          new ListTile(
            title: new Text('Time: ${widget.time}'),
          ),
        ],
      ),
    );
  }
}
