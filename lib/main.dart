import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  late SharedPreferences _preferences;
  String _username = "";
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  _saveUsername() {
    setState(
      () => {
        _username = _usernameController.text,
        _preferences.setString("username", _username),
      },
    );
  }

  _getUsername() async {
    _preferences = await SharedPreferences.getInstance();
    setState(
      () => _username = _preferences.getString("username") ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Title"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Text("현재 사용자 이름: ${_username}"),
          Container(
            child: TextField(
              controller: _usernameController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "사용자 이름을 입력하세요",
              ),
            ),
          ),
          TextButton(
            onPressed: () => _saveUsername(),
            child: const Text("저장"),
          )
        ],
      ),
    );
  }
}
