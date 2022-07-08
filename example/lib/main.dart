import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:safe_stream_value/safe_stream_value.dart';

void main() {
  runApp(const MyApp());
}

class Bloc {
  final _myBehaviorSubject = BehaviorSubject<String>();
  final _myStream = StreamController<String>();

  Stream<String> get myBehaviorSubject => _myBehaviorSubject.stream;
  Stream<String> get myStream => _myStream.stream;

  void doSomethingOnStreams() async {
    _myBehaviorSubject.safeValue = 'Hello';
    await Future.delayed(const Duration(seconds: 1));
    _myStream.safeValue = 'World';
  }

  void dispose() {
    _myBehaviorSubject.close();
    _myStream.close();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Bloc _bloc;
  int _counter = 0;

  @override
  void initState() {
    _bloc = Bloc();
    _listenBlocStreams();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _listenBlocStreams() {
    _bloc.myStream.listen((String value) {
      Fluttertoast.showToast(msg: value);
    });

    _bloc.myBehaviorSubject.listen((String value) {
      Fluttertoast.showToast(msg: value);
    });
  }

  void _incrementCounter() {
    _bloc.doSomethingOnStreams();
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
