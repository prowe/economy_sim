import 'dart:async';

import 'package:economy_sim/engine/game_cell.dart';
import 'package:economy_sim/engine/game_field.dart';
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
      home: GamePanel(title: 'Flutter Demo Home Page'),
    );
  }
}

class GamePanel extends StatefulWidget {
  GamePanel({Key? key, required this.title})
      : gameField = GameField.generate(width: 5, height: 10),
        super(key: key);

  final String title;
  final GameField gameField;

  @override
  State<GamePanel> createState() => _GamePanelState();
}

class _GamePanelState extends State<GamePanel> {
  _GamePanelState() {
    cycleTimer = Timer.periodic(const Duration(seconds: 3), _onCycleTick);
  }

  late Timer cycleTimer;

  void _onCycleTick(Timer timer) {
    setState(() {
      widget.gameField.executeCycle();
    });
  }

  @override
  Widget build(BuildContext context) {
    var gameField = widget.gameField;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: GridView.count(
          crossAxisCount: gameField.width,
          children:
              gameField.cells.map((cell) => CellWidget(cell: cell)).toList()),
    );
  }
}

class CellWidget extends StatelessWidget {
  const CellWidget({Key? key, required this.cell}) : super(key: key);

  final GameCell cell;

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
      child: const Text('C'),
    );
  }

  Widget _buildCellDetailSheet(BuildContext context) {
    return CellDetailSheet(cell: cell);
  }
}

class CellDetailSheet extends StatelessWidget {
  const CellDetailSheet({Key? key, required this.cell}) : super(key: key);

  final GameCell cell;

  List<Widget> _buildInventoryListItems() {
    return cell
        .inventory()
        .entries
        .map<Widget>((entry) => ListTile(
              title: Text(entry.key),
              trailing: Text("${entry.value}"),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Column(children: [
          Icon(
            Icons.remove,
            color: Colors.grey[600],
          ),
          Expanded(
              child: ListView(
            shrinkWrap: true,
            children: _buildInventoryListItems(),
          ))
        ]));

    // return ListView(
    //   shrinkWrap: true,
    //   children: _buildInventoryListItems(),
    // );

    // SingleChildScrollView(
    //     child: Column(
    //   mainAxisSize: MainAxisSize.min,
    //   ,
    //   children: <Widget>[
    //     const Text("Title 1"),
    //     ] + inventoryItems.toList()
    //   ],
    // ));
  }
}
