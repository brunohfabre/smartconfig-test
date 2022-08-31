import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'connectivity_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.location.request();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnectivityPage(),
    );
  }
}
