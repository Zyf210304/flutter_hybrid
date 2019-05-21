
import 'package:flutter/material.dart';
import 'dart:ui';

void main() => runApp(MyApp(initParams:window.defaultRouteName,));

class MyApp extends StatelessWidget {
  final String initParams;

  const MyApp({Key key, this.initParams}):super(key:key);

  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', initParams:initParams),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title, this.initParams}) : super(key: key);

  final String title;
  final String initParams;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              // 'You have pushed the button this many times:',
              'initParams:${widget.initParams}',
              style:TextStyle(fontSize: 20),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
