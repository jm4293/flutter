import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() => _selectedIndex = _tabController.index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Test Title"),
          backgroundColor: Colors.blue,
        ),
        body: _selectedIndex == 0
            ? tabContainer(context, Colors.blue, "Home")
            : _selectedIndex == 1
                ? tabContainer(context, Colors.red, "Search")
                : tabContainer(context, Colors.green, "Settings"),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          tabs: [
            Tab(
              icon: Icon(
                _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
              ),
              text: "Home",
            ),
            Tab(
              icon: Icon(_selectedIndex == 1 ? Icons.search : Icons.search_outlined),
              text: "Search",
            ),
            Tab(
              icon: Icon(
                _selectedIndex == 2 ? Icons.settings : Icons.settings_outlined,
              ),
              text: "Settings",
            ),
          ],
        ),
      ),
    );
  }

  Widget tabContainer(BuildContext context, Color tabColor, String tabText) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: tabColor,
      child: Center(
        child: Text(
          tabText,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
