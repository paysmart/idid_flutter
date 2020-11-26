import 'package:flutter/material.dart';
import 'package:idid_flutter/idid_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> isProvisioned;

  @override
  void initState() {
    super.initState();
    _isProvisioned();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder(
                future: isProvisioned,
                initialData: false,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: TextStyle(fontSize: 16),
                  );
                },
              ),
              ElevatedButton(
                child: Text('PROVISIONAR!'),
                onPressed: () {
                  IdidFlutter.provision({});
                },
              ),
              ElevatedButton(
                child: Text('AUTORIZAR!'),
                onPressed: () {
                  IdidFlutter.authorize({});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _isProvisioned() => isProvisioned = IdidFlutter.isProvisioned();
}
