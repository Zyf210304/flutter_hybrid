// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'dart:ui';

// import 'package:flutter/services.dart';

// void main() => runApp(MyApp(
//       initParams: window.defaultRouteName,
//     ));

// class MyApp extends StatelessWidget {
//   final String initParams;

//   const MyApp({Key key, this.initParams}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter 混合开发', initParams: initParams),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title, this.initParams}) : super(key: key);

//   final String title;
//   final String initParams;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   static const EventChannel _eventChannelPlugin =
//       EventChannel('EventChannelPlugin');

//   StreamSubscription _streamSubscription;

//   static const MethodChannel _methodChannelPlugin =
//       MethodChannel('MethodChannelPlugin');

//   static const BasicMessageChannel<String> _basicMessageChannelPlugin =
//       const BasicMessageChannel('BasicMessageChannelPlugin', StringCodec());

//   String showMessage = '暂未接收数据';
//   bool _isMethodChannelPlugin = false;

//   @override
//   void initState() {
//     _streamSubscription = _eventChannelPlugin
//         .receiveBroadcastStream('123')
//         .listen(_onToDart, onError: _onToDartError);

//     _basicMessageChannelPlugin
//         .setMessageHandler((String message) => Future<String>(() {
//               setState(() {
//                 showMessage = '_basicMessageChannelPlugin' + message;
//               });
//               return "收到Native的消息:" + message;
//             }));

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _streamSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(color:Colors.blueAccent),
//         child: Column(
        
//         children: <Widget>[
//           Text(
//             'initParams:${widget.initParams}',
//             style: TextStyle(fontSize: 20),
//           ),
//           Text(
//             '接收消息$showMessage',
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.red,
//               backgroundColor: Colors.orangeAccent,
//             ),
            
//           ),
//           SwitchListTile(
//             value: _isMethodChannelPlugin,
//             onChanged: _onChannelChanged,
//             title: Text(_isMethodChannelPlugin
//                 ? '_methodChannelPlugin'
//                 : '_basicMessageChannelPlugin'),
//           ),
          
//           TextField(
//             onChanged: _onTextChange,
//             cursorColor:Colors.red,
//             decoration: InputDecoration(
//               focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white)),
//               enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white)),
//             ),
//           ),
          
//         ],
//       ),
//       )
//     );
//   }

//   void _onToDart(message) {
//     setState(() {
//       showMessage = message;
//     });
//   }

//   void _onToDartError(error) {
//     print(error);
//   }

//   void _onChannelChanged(bool value) {
//     setState(() {
//       _isMethodChannelPlugin = value;
//     });
//   }

//   void _onTextChange(value) async {
//     String response;
//     try {
//       if (_isMethodChannelPlugin) {
//         response = await _methodChannelPlugin.invokeMethod('send', value);
//       } else {
//         response = await _basicMessageChannelPlugin.send(value);
//       }
//     } on PlatformException catch (e) {
//       print(e);
//     }
//     setState(() {
//       showMessage = response ?? "";
//     });

//   }
// }
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp(
      initParams: window.defaultRouteName,
    ));

class MyApp extends StatelessWidget {
  final String initParams;

  const MyApp({Key key, this.initParams}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 混合开发',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter 混合开发',
        initParams: initParams,
      ),
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
  static const EventChannel _eventChannelPlugin =
      EventChannel('EventChannelPlugin');
  String showMessage = "";
  static const MethodChannel _methodChannelPlugin =
      const MethodChannel('MethodChannelPlugin');
  static const BasicMessageChannel<String> _basicMessageChannel =
      const BasicMessageChannel('BasicMessageChannelPlugin', StringCodec());
  bool _isMethodChannelPlugin = false;
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    _streamSubscription = _eventChannelPlugin
        .receiveBroadcastStream('123')
        .listen(_onToDart, onError: _onToDartError);
    //使用BasicMessageChannel接受来自Native的消息，并向Native回复
    _basicMessageChannel
        .setMessageHandler((String message) => Future<String>(() {
              setState(() {
                showMessage = 'BasicMessageChannel:'+message;
              });
              return "收到Native的消息：" + message;
            }));
    super.initState();
  }

  @override
  void dispose() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }
    super.dispose();
  }

  void _onToDart(message) {
    setState(() {
      showMessage = 'EventChannel:'+message;
    });
  }

  void _onToDartError(error) {
    print(error);
  }

  void _onTextChange(value) async {
    String response;
    try {
      if (_isMethodChannelPlugin) {
        //使用BasicMessageChannel向Native发送消息，并接受Native的回复
        response = await _methodChannelPlugin.invokeMethod('send', value);
      } else {
        response = await _basicMessageChannel.send(value);
      }
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      showMessage = response ?? "";
    });
  }

  void _onChanelChanged(bool value) =>
      setState(() => _isMethodChannelPlugin = value);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 20);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        margin: EdgeInsets.only(top: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SwitchListTile(
              value: _isMethodChannelPlugin,
              onChanged: _onChanelChanged,
              title: Text(_isMethodChannelPlugin
                  ? "MethodChannelPlugin"
                  : "BasicMessageChannelPlugin"),
            ),
            TextField(
              onChanged: _onTextChange,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
            Text(
              '收到初始参数initParams:${widget.initParams}',
              style: textStyle,
            ),
            Text(
              'Native传来的数据：' + showMessage,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}