# safe_stream_value
[![pub package](https://img.shields.io/pub/v/safe_stream_value.svg)](https://pub.dev/packages/safe_stream_value)

Set of extensions to safely set value to stream controllers in flutter and rxDart

## What is safeValue?
If you have an StreamController object and you close it and then try to set a value to it, 
there will be an error indicating you cannot set value to already closed stream.

That's the sole purpose of this library to check if stream is open and set value for you.

## Usage

To use this plugin, add [widget_size](https://pub.dev/packages/safe_stream_value/install) as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  safe_stream_value: ^lastVersion
```

then you can use it like this:

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:safe_stream_value/safe_stream_value.dart';

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

```
