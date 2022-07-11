import 'dart:async';
import 'package:rxdart/rxdart.dart';

/// No-Op function
void doNothing() {}

/// Add value to the stream only when it is not closed, otherwise do nothing
extension BehaviorSubjectExtensions<T> on BehaviorSubject<T> {
  /// Safely set value to the stream and do nothing if stream is closed
  set safeValue(T newValue) => isClosed == false ? add(newValue) : doNothing();
}

/// Add value to the stream only when it is not closed, otherwise do nothing
extension PublishSubjectExtensions<T> on PublishSubject<T> {
  /// Safely set value to the stream and do nothing if stream is closed
  set safeValue(T newValue) => isClosed == false ? add(newValue) : doNothing();
}

/// Add value to the stream only when it is not closed, otherwise do nothing
extension ReplaySubjectExtensions<T> on ReplaySubject<T> {
  /// Safely set value to the stream and do nothing if stream is closed
  set safeValue(T newValue) => isClosed == false ? add(newValue) : doNothing();
}

/// Add value to the stream only when it is not closed, otherwise do nothing
extension StreamControllerExtensions<T> on StreamController<T> {
  /// Safely set value to the stream and do nothing if stream is closed
  set safeValue(T newValue) => isClosed == false ? add(newValue) : doNothing();
}
