import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Knitt3r',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var dataCounters = [0, 0, 0, 0];
  var dataCounterName = ['Counter 0', 'Counter 1', 'Counter 2', 'Counter 3'];
  var dataColors = [
    0xFF6a1b9a,
    0xFFff8f00,
    0xFF4caf50,
    0xFFdd2c00,
    0xFF1976d2,
    0xFF4fc3f7,
    0xFF26a69a,
    0xFFab47bc,
    0xFFffea00,
    0xFF795548,
    0xFF6a1b9a,
    0xFFff8f00,
    0xFF4caf50,
    0xFFdd2c00,
    0xFF1976d2,
    0xFF4fc3f7,
    0xFF26a69a,
    0xFFffea00,
    0xFF795548,
    0xFF6a1b9a,
    0xFFff8f00,
    0xFF4caf50,
    0xFFdd2c00,
    0xFF1976d2,
    0xFF4fc3f7,
    0xFF26a69a,
  ];

  void _incrementCounter(index) {
    setState(() {
      dataCounters[index]++;
    });
  }

  void _decrementCounter(index) {
    setState(() {
      dataCounters[index]--;
    });
  }

  void _changeCounterName(index) {
    print('Change name of ${dataCounterName[index]}');
    String newName = '';
    showDialog<String>(
      context: context,
      barrierDismissible:
          true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: const Color(0xFF424242),
          title: Text(
            '${dataCounterName[index]}',
            style: TextStyle(color: Colors.white),
          ),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'New name',
                    hintText: 'eg. Cats',
                  ),
                  onChanged: (value) {
                    newName = value;
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'DELETE',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    setState(() {
                      dataCounterName.removeAt(index);
                      dataCounters.removeAt(index);
                      Navigator.of(context).pop(newName);
                    });
                  },
                ),
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    setState(() {
                      dataCounterName[index] = newName;
                      Navigator.of(context).pop(newName);
                    });
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _resetCounter(index) {
    setState(() {
      dataCounters[index] = 0;
    });
  }

  void _actionAction(index) {
    switch (index) {
      case 0:
        {
          setState(() {
            print('New Counter! $index');
            dataCounters.add(0);
            dataCounterName.add('Counter ${dataCounters.length}');
          });
        }
        break;
      case 1:
        {
          print("Open Calculator!");
        }
        break;
      case 2:
        {
          print("App information");
          print('Number of Counters: ${dataCounters.length}');
          print('Counter names: ${dataCounterName}');
        }
        break;
      default:
        {
          print('Action missing for index $index');
        }
        break;
    }
  }

  AnimationController _controller;

  static const List<IconData> icons = const [
    Icons.add,
    Icons.exposure,
    Icons.info
  ];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return Scaffold(
      backgroundColor: const Color(0xFF424242),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          //title: Text('Knitt3r'),
          backgroundColor: const Color(0xFF424242),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(icons.length, (int index) {
          Widget child = Container(
            height: 70.0,
            width: 40.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true,
                child: Icon(icons[index], color: Colors.pinkAccent),
                onPressed: () {
                  _actionAction(index);
                  _controller.reverse();
                },
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            FloatingActionButton(
              backgroundColor: Colors.pinkAccent,
              heroTag: null,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return Transform(
                    transform:
                        Matrix4.rotationZ(_controller.value * 1.0 * math.pi),
                    alignment: FractionalOffset.center,
                    child: Icon(
                        _controller.isDismissed ? Icons.menu : Icons.clear_all),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),
          ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
//            Container(
//              height: 150,
//              child: Text('Above it all!'),
//            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25.0,
                  mainAxisSpacing: 25.0,
                ),
                itemCount: dataCounters.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: Text(dataCounterName[index],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                          onLongPress: () {
                            _changeCounterName(index);
                          },
                        ),
                        FlatButton(
                          child: Text(dataCounters[index].toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40)),
                          onLongPress: () {
                            _resetCounter(index);
                          },
                        ),
                        Text("",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.all(12),
                                child: Icon(Icons.remove),
                                //color: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  _decrementCounter(index);
                                },
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                padding: EdgeInsets.all(12),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                //color: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  _incrementCounter(index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(dataColors[index]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 5.0,
                          spreadRadius: -3.0,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
