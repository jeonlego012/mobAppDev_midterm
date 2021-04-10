import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _isExpanded = false;
  List<bool> checked = [false, false, false];
  List<String> checkText = ['No Kids Zone', 'Pet-Friendly', 'Free Breakfast'];
  DateTime _selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: ExpansionPanelList(
              expansionCallback: (_, isExpanded) => setState(() {
                _isExpanded = !_isExpanded;
              }),
              children: [
                ExpansionPanel(
                  body: Container(
                    padding: EdgeInsets.only(left: 100.0),
                    child: Column(
                      children: [
                        for (var i = 0; i < 3; i++)
                          Row(
                            children: [
                              Checkbox(
                                onChanged: (bool value) {
                                  setState(() {
                                    checked[i] = value;
                                  });
                                },
                                value: checked[i],
                              ),
                              Text(checkText[i]),
                            ],
                          ),
                      ],
                    ),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Row(
                      children: [
                        SizedBox(width: 20.0),
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 50.0),
                        Text(
                          'select filters',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    );
                  },
                  isExpanded: _isExpanded,
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(width: 20.0),
              Container(
                padding: EdgeInsets.only(top: 20.0, left: 20.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'check-in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(DateFormat.yMMMd().format(_selectedTime)),
                    ],
                  ),
                  RaisedButton(
                    color: Colors.blue[100],
                    onPressed: () {
                      Future<DateTime> selectedDate = showDatePicker(
                        context: context,
                        initialDate: _selectedTime,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2037),
                      );
                      selectedDate.then((dateTime) {
                        setState(() {
                          _selectedTime = dateTime;
                        });
                      });
                    },
                    child: Text('select date'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 300.0),
          Container(
            padding: EdgeInsets.only(left: 150.0, right: 150.0),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                elevation: 5,
              ),
              onPressed: () => _showResult(),
              child: Text('Search'),
            ),
          ),
        ],
      ),
    );
  }

  void _showResult() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                'Please check your options:)',
                style: TextStyle(
                  decorationColor: Colors.blue,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: Colors.blue,
                        ),
                        Column(
                          children: [
                            for (var i = 0; i < 3; i++)
                              if (checked[i])
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, bottom: 8.0),
                                  child: Text(checkText[i]),
                                ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Icon(
                          Icons.event,
                          color: Colors.blue,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'IN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(DateFormat.yMMMd().format(_selectedTime)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Container(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Search'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ]);
        });
  }
}
