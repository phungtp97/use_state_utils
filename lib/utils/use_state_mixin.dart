import 'package:flutter/material.dart';
import 'dart:async';
import '../use_state_utils.dart';

/// A mixin for managing state-related resources in a StatefulWidget.
/// It simplifies the creation and lifecycle management of objects like
/// AnimationControllers, StreamSubscriptions, Timers, and ValueNotifiers.
mixin UseStateMixin<T extends StatefulWidget> on State<T> {
  final Map<String, UseStateScene<dynamic>> _useStateScenes = {};

  /// Retrieves an existing AnimationController or creates a new one.
  ///
  /// [key]: A unique string key to identify the AnimationController.
  /// [vsync]: The TickerProvider for the AnimationController.
  /// [duration]: The duration of the animation.
  ///
  /// Returns an [AnimationController] associated with the given key.
  AnimationController useAnimationController({
    required String key,
    required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return _getOrCreate(
      key: key,
      create: () => AnimationController(vsync: vsync, duration: duration),
      disposeHandler: (controller) async => controller.dispose()
    );
  }

  /// Retrieves an existing ValueNotifier or creates a new one.
  ///
  /// [key]: A unique string key to identify the ValueNotifier.
  /// [initialValue]: The initial value of the ValueNotifier.
  ///
  /// Returns a [ValueNotifier] associated with the given key.
  ValueNotifier<V> useNotifier<V>({
    required String key,
    required V initialValue,
  }) {
    return _getOrCreate(
      key: key,
      create: () => ValueNotifier<V>(initialValue),
      disposeHandler: (notifier) async => notifier.dispose()
    );
  }

  /// Subscribes to a stream and manages the subscription lifecycle.
  ///
  /// [key]: A unique string key to identify the StreamSubscription.
  /// [stream]: The stream to subscribe to.
  /// [onData]: A callback to handle incoming data events.
  ///
  /// Returns a [StreamSubscription] associated with the given key.
  StreamSubscription<S> useStreamSubscription<S>({
    required String key,
    required Stream<S> stream,
    required void Function(S event) onData,
  }) {
    return _getOrCreate(
      key: key,
      create: () => stream.listen(onData),
      disposeHandler: (subscription) async => subscription.cancel()
    );
  }

  /// Retrieves or creates a one-time Timer.
  ///
  /// [key]: A unique string key to identify the Timer.
  /// [callback]: The function to execute when the timer fires.
  /// [duration]: The duration after which to fire the timer.
  ///
  /// Returns a [Timer] associated with the given key.
  Timer useTimer({
    required String key,
    required void Function() callback,
    required Duration duration,
  }) {
    return _getOrCreate(
      key: key,
      create: () => Timer(duration, callback),
      disposeHandler: (timer) async => timer.cancel()
    );
  }

  /// Retrieves or creates a periodic Timer.
  ///
  /// [key]: A unique string key to identify the periodic Timer.
  /// [callback]: The function to execute on each timer tick.
  /// [duration]: The interval between timer ticks.
  ///
  /// Returns a [Timer] that fires periodically, associated with the given key.
  Timer usePeriodicTimer({
    required String key,
    required void Function(Timer) callback,
    required Duration duration,
  }) {
    return _getOrCreate(
      key: key,
      create: () => Timer.periodic(duration, callback),
      disposeHandler: (timer) async => timer.cancel()
    );
  }

  /// Retrieves or creates a custom managed resource.
  ///
  /// [key]: A unique string key to identify the custom resource.
  /// [createHandler]: A function to create the resource.
  /// [disposeHandler]: A function to dispose of the resource.
  ///
  /// Returns the custom resource associated with the given key.
  R useCustomScene<R>({
    required String key,
    required R Function() createHandler,
    required Future<void> Function(R) disposeHandler,
  }) {
    return _getOrCreate(
      key: key,
      create: createHandler,
      disposeHandler: disposeHandler,
    );
  }

  /// Retrieves a previously created UseStateScene object.
  /// _object is the object that was created with the key.
  /// _object is immutable
  UseStateScene<P>? getUseStateScene<P>(String key) {
    if (_useStateScenes.containsKey(key) && _useStateScenes[key]?.object is P) {
      return _useStateScenes[key] as UseStateScene<P>;
    }
    return null;
  }

  /// A utility method to either retrieve an existing resource or create it.
  M _getOrCreate<M>({
    required String key,
    required M Function() create,
    required Future<void> Function(M) disposeHandler,
  }) {
    if (_useStateScenes.containsKey(key) && _useStateScenes[key]?.object is M) {
      return _useStateScenes[key]!.object as M;
    }
    final resource = create();
    _useStateScenes[key] = UseStateScene<M>(
      object: resource,
      disposeHandler: disposeHandler,
    );
    return resource;
  }

  /// Disposes all managed resources upon the disposal of the state.
  @mustCallSuper
  @override
  void dispose() {
    _disposeAll();
    super.dispose();
  }

  void _disposeAll() async{
    for (var scene in _useStateScenes.entries) {
      scene.value.dispose().then((value) {
        if (UseStateConfig.debugPrintOnFailedDispose) {
          debugPrint('Disposed useState resource ${scene.key}');
        }
      }).catchError((e) {
        if (UseStateConfig.debugPrintOnFailedDispose) {
          debugPrint('Error disposing useState resource ${scene.key}: $e');
        }
      });
    }
    _useStateScenes.clear();
  }
}

class UseStateScene<T> {
  final T _object;
  final Future<void> Function(T) _disposeHandler;

  UseStateScene({
    required T object,
    required Future<void> Function(T) disposeHandler,
  })  : _object = object,
        _disposeHandler = disposeHandler;

  T get object => _object;

  Future<void> dispose() => _disposeHandler(_object);
}
