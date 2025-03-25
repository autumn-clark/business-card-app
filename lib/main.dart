import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/business_card_provider.dart';
import 'package:flutter_application_1/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BusinessCardProvider()),
      // other providers if any
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: ChangeNotifierProvider(
        create: (context) => BusinessCardProvider()..loadCards(),  // Corrected syntax
        child: const RootPage(),
      ),
    );
  }
}