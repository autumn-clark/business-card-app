import 'package:flutter/material.dart';
import 'package:flutter_application_1/add_page.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_application_1/insight_page.dart';
import 'package:flutter_application_1/map_page.dart';
import 'package:flutter_application_1/settings_page.dart';

void main() {
  runApp(const MyApp());
}

MaterialColor customSwatch = MaterialColor(
  0xFFFFBB4D,
  <int, Color>{
    50: Color(0xFFFFE5CC),
    100: Color(0xFFFFD4A3),
    200: Color(0xFFFFC27A),
    300: Color(0xFFFFB051),
    400: Color(0xFFFFA138),
    500: Color(0xFFFFBB4D), // Main color
    600: Color(0xFFFF9A1E),
    700: Color(0xFFFF8808),
    800: Color(0xFFFF7700),
    900: Color(0xFFFF5500),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: customSwatch, // Custom primary color
        scaffoldBackgroundColor:
            Color.fromRGBO(239, 239, 239, 1), // Dark mode background
        textTheme: const TextTheme(
          bodyLarge:
              TextStyle(color: Color.fromRGBO(26, 30, 91, 1), fontSize: 18),
          bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Color.fromRGBO(26, 30, 91, 1),
          ),
          backgroundColor: Colors.transparent, // Custom app bar color
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  final List<Widget> pages = [
    const HomePage(),
    const MapPage(),
    const AddPage(),
    const InsightPage(),
    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(

        unselectedIconTheme: IconThemeData(
          color: Color.fromRGBO(26, 30, 91, 1),
          
        ),
        selectedIconTheme: IconThemeData(
          color: Colors.indigo
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        
        currentIndex: currentPage,
        onTap: (int index){
          setState(() {
            currentPage = index;
          });
        },
      ),
      // bottomNavigationBar: NavigationBar(
      //   destinations: const [
      //     NavigationDestination(
      //       icon: Icon(Icons.home),
      //       label: '',
      //     ),
      //     NavigationDestination(icon: Icon(Icons.location_on), label: ''),
      //     NavigationDestination(
      //         icon: Icon(Icons.add_circle_outline), label: ''),
      //     NavigationDestination(icon: Icon(Icons.bar_chart), label: ''),
      //     NavigationDestination(icon: Icon(Icons.settings), label: ''),
      //   ],
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPage = index;
      //     });
      //   },
      //   selectedIndex: currentPage,
      // ),
    );
  }
}
