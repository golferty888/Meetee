import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;

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
  TimeOfDay _time = TimeOfDay.now();

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
            title: Text('Date select: ${_time.toString()}'),
            subtitle: RaisedButton(
              child: Text('Select time'),
              onPressed: () {
                _selectTime(context);
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
                  builder: (context) => ChooseSeat(
                        seatType: '${widget.seatType}',
                        date: DateFormat('yyyy-MM-dd').format(_date),
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
            title: Text('Time: ${widget.time}'),
          ),
        ],
      ),
    );
  }
}
