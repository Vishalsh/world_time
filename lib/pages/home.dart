import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map routeData = {};

  void setData() async {
    dynamic data = await Navigator.pushNamed(context, '/location');

    if (data != null) {
      setState(() {
        routeData = {
          'location': data['location'],
          'time': data['time'],
          'flag': data['flag'],
          'isDayTime': data['isDayTime']
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    routeData = routeData.isNotEmpty ? routeData : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: routeData['isDayTime'] ? Colors.blue : Colors.indigo[700],
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/${routeData['isDayTime'] ? 'day.png' : 'night.png'}'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                FlatButton.icon(
                  onPressed: () {
                    setData();
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300]
                    ),
                  )),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      routeData['location'],
                      style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 28.0,
                        color: Colors.white
                      ),
                    ),
                  ]
                ),
                SizedBox(height: 20.0),
                Text(
                  routeData['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
