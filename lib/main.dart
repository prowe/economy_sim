import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GamePanel(title: 'Flutter Demo Home Page'),
    );
  }
}

class GamePanel extends StatefulWidget {
  const GamePanel({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GamePanel> createState() => _GamePanelState();
}

class _GamePanelState extends State<GamePanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 5,
        children: List.generate(
            50, (index) => Cell(key: Key(index.toString()), title: "C $index")),
      ),
    );
  }
}

class Cell extends StatelessWidget {
  const Cell({Key? key, required this.title}) : super(key: key);

  final String title;

  _decoration() {
    return BoxDecoration(
        border: Border.all(
      color: Colors.black,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: _decoration(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title),
            ]));
  }
}
