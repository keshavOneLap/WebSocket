import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreen extends StatefulWidget {
  final WebSocketChannel webSocketChannel;
  HomeScreen({required this.webSocketChannel});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Send Message To Web Socket',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: _sendMyMessage, child: Text('Send To The Web Socket')),
          SizedBox(
            height: 16,
          ),
          StreamBuilder(
              stream: widget.webSocketChannel.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  child: Text(
                    snapshot.hasData
                        ? 'Response Sent From Web Socket is: ${snapshot.data.toString()}'
                        : '',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }),
        ],
      ),
    );
  }

  void _sendMyMessage() {
    if (_controller.text.isNotEmpty) {
      widget.webSocketChannel.sink.add(_controller.text);
    }
  }
}
