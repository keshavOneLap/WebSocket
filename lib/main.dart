import 'package:flutter/material.dart';
import 'package:web_socket_application/home_screen.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Url To Connect'),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            HomeScreen(
              webSocketChannel: IOWebSocketChannel.connect(
                _controller.text.isEmpty
                    ? 'ws://echo.websocket.org'
                    : _controller.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
