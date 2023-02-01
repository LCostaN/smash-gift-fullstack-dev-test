import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smash_gift_app/ui/country_list.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smash Gift Test App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CountryList(),
    );
  }
}
