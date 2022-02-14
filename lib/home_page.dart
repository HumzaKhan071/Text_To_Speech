import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSpeaking = false;
  final TextEditingController _controller = TextEditingController();
  final _flutterTts = FlutterTts();

  void intializeTts() {
    _flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });
    _flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
    _flutterTts.setErrorHandler((message) {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  @override
  void initState() {
    intializeTts();
    super.initState();
  }

  void speak() async {
    if (_controller.text.isNotEmpty) {
      await _flutterTts.speak(_controller.text);
    }
  }

  void stop() async {
    await _flutterTts.stop();
  }

  @override
  void dispose() {
    super.dispose();
    _flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text to Speak"),
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            child: TextField(
              controller: _controller,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                isSpeaking ? stop() : speak();
              },
              child: Text(isSpeaking ? "Stop" : "Speak"))
        ],
      ),
    );
  }
}
