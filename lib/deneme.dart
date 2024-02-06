import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Deneme extends StatefulWidget {
  const Deneme({super.key});

  @override
  State<Deneme> createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devicesList.contains(result.device)) {
          setState(() {
            devicesList.add(result.device);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth Devices'),
        ),
        body: ListView.builder(
          itemCount: devicesList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(devicesList[index].name),
              subtitle: Text(devicesList[index].id.toString()),
            );
          },
        ));
  }
}
