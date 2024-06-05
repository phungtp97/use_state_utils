import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:use_state_utils/use_state_utils.dart';
import 'package:rxdart/rxdart.dart';
// Update this with the path to UseStateMixin

void main() {
  UseStateConfig.debugPrintOnFailedDispose = true;
  UseStateConfig.debugPrintOnSuccessDispose = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: HomePage(), // Use DemoPage as the home widget
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.blue.withOpacity(0.5)));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DemoPage()));
                },
                child: const Text('Demo Page'))));
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage>
    with UseStateMixin<DemoPage>, TickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<Color?> _colorTween;
  late BehaviorSubject<int?> _streamController;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _animationController = useAnimationController(key: 'anim1', vsync: this);
    _colorTween = ColorTween(begin: Colors.cyan, end: Colors.deepOrange)
        .animate(_animationController);

    usePeriodicTimer(
        key: 'timer1',
        callback: _handleTimer,
        duration: const Duration(seconds: 1));

    _streamController = BehaviorSubject.seeded(null);

    useStreamSubscription(
      key: 'stream1',
      stream: _streamController,
      onData: _handleStreamData,
    );
  }

  void _handleTimer(Timer timer) {
    setState(() {
      _counter++;
    });
  }

  void _handleStreamData(int? data) {
    if (data == null) return;
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Stream Alert'),
            content: Text('Stream sent: $data'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UseStateMixin Demo'),
      ),
      body: AnimatedBuilder(
          animation: _colorTween,
          builder: (context, _) {
            return Material(
              color: _colorTween.value,
              key: const Key('background'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Center(child: Text('Fade Transition')),
                  ElevatedButton(
                    onPressed: () {
                      if (_animationController.isCompleted) {
                        _animationController.reverse();
                      } else {
                        _animationController.forward();
                      }
                    },
                    child: const Text('Toggle Animation'),
                  ),
                  const SizedBox(height: 20),
                  Text('Timer count: $_counter'),
                  ElevatedButton(
                    onPressed: () => _streamController.add(99),
                    child: const Text('Send Stream Data'),
                  ),
                ],
              ),
            );
          }),
    );
  }



}




