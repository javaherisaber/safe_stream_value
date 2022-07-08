import 'dart:async';
import 'package:rxdart/rxdart.dart';

void doNothing() {}

/// Add value to the stream only when it is not closed, otherwise do nothing
extension BehaviorSubjectExtensions<T> on BehaviorSubject<T> {
  set safeValue(T newValue) => isClosed == false ? add(newValue) : doNothing();
}

extension PublishSubjectExtensions<T> on PublishSubject<T> {
  set safeValue(T newValue) => isClosed == false ? add(newValue) : doNothing();
}

extension ReplaySubjectExtensions<T> on ReplaySubject<T> {
  set safeValue(T newValue) => isClosed == false ? add(newValue) : doNothing();
}

extension StreamControllerExtensions<T> on StreamController<T> {
  set safeValue(T newValue) => isClosed == false ? add(newValue) : doNothing();
}