import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

void main() {
  runApp(MyApp());
}

const cellHeight = 60.0;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calendar'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final scrollController = ScrollController(
    initialScrollOffset: (cellHeight * 8) - 20,
  );

  final tasks = <_TimePlannerTask>[
    _TimePlannerTask(
      startTime: DateTime(2017, 9, 7, 14, 0),
      endTime: DateTime(2017, 9, 7, 15, 0),
      title: "Meeting Flutter",
    ),
    _TimePlannerTask(
      startTime: DateTime(2017, 9, 7, 9, 0),
      endTime: DateTime(2017, 9, 7, 10, 15),
      title: "Breakfast Flutter",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                SizedBox(
                  height: cellHeight,
                ),
                for (int i = 1; i <= 23; i++) ...[
                  Divider(
                    height: 0,
                    indent: 70,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: cellHeight,
                  ),
                ]
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: cellHeight - 10,
                ),
                for (int i = 1; i <= 23; i++) _HourText(hour: i),
              ],
            ),
            ...tasks,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _HourText extends StatelessWidget {
  const _HourText({
    Key key,
    this.hour,
  }) : super(key: key);

  final int hour;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cellHeight,
      color: Colors.white70,
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Text('$hour:00'),
      ),
    );
  }
}

class _TimePlannerTask extends StatelessWidget {
  const _TimePlannerTask({
    Key key,
    @required this.startTime,
    @required this.endTime,
    @required this.title,
  }) : super(key: key);

  final DateTime startTime;
  final DateTime endTime;
  final String title;

  @override
  Widget build(BuildContext context) {
    final duration = endTime.difference(startTime);
    return Positioned(
      top: (cellHeight * startTime.hour).toDouble(),
      left: 70,
      right: 10,
      child: InkWell(
        onTap: null,
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Container(
            height: (duration.inMinutes * cellHeight / 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Theme.of(context).primaryColor,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  title,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
