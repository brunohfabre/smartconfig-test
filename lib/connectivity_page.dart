import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:esptouch_smartconfig/esptouch_smartconfig.dart';
import 'package:flutter/material.dart';

import 'wifi_page.dart';

class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({super.key});

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  late Connectivity _connectivity;
  late Stream<ConnectivityResult> _connectivityStream;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult? result;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivityStream = _connectivity.onConnectivityChanged;
    _connectivitySubscription = _connectivityStream.listen((e) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EspTouch"),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder(
          future: _connectivity.checkConnectivity(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == ConnectivityResult.wifi) {
              return FutureBuilder<Map<String, String>?>(
                  future: EsptouchSmartconfig.wifiData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return WifiPage(snapshot.data!['wifiName']!,
                          snapshot.data!['bssid']!);
                    } else {
                      return Container();
                    }
                  });
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.wifi_off_sharp,
                      size: 200,
                      color: Colors.red,
                    ),
                    Text(
                      "No Wifi !!",
                      style: TextStyle(fontSize: 40, color: Colors.red),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
