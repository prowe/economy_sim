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
            50,
            (index) =>
                CellWidget(key: Key(index.toString()), title: "C $index")),
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  const CellWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  _buttonStyle() {
    return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: Colors.grey))));
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showModalBottomSheet(
          context: context, builder: _buildCellDetailSheet),
      style: _buttonStyle(),
      child: Text(title),
    );
  }

  Widget _buildCellDetailSheet(BuildContext context) {
    return const CellDetailSheet();
  }
}

class CellDetailSheet extends StatelessWidget {
  const CellDetailSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text("Title 1"),
        ListTile(
          title: Text('Music'),
          trailing: Text('45'),
        ),
        ListTile(
          title: Text('Video'),
          trailing: Text('45'),
        ),
        ListTile(
          title: Text('Share'),
          trailing: Text('45'),
        ),
        // ElevatedButton(
        //     onPressed: () => Navigator.pop(context), child: const Text("Close"))
      ],
    ));
  }
}
