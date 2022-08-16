import 'package:collection/collection.dart';
import 'package:economy_sim/engine/game_cell.dart';

class GameField {
  GameField({required this.width, required this.cells});

  GameField.generate({required this.width, required int height})
      : cells = List.generate(width * height, (index) => GameCell());

  final int width;
  final List<GameCell> cells;

  void executeCycle() {
    _applySunlight();
    _executeCurrentRecipe();
    _conductToNeighbors();
    _commitTransactions();
  }

  void _applySunlight() {
    for (var c in cells) {
      c.queueTransaction('Sunlight', 10);
    }
  }

  void _executeCurrentRecipe() {
    for (var c in cells) {
      c.executeCurrentRecipe();
    }
  }

  void _conductToNeighbors() {
    cells.forEachIndexed((index, cell) {
      var neighbors = _neighborsForCellIndex(index);
      cell.conductInventoryToNeighbors(neighbors);
    });
  }

  List<GameCell> _neighborsForCellIndex(int centerIndex) {
    List<GameCell> neighbors = [];
    if (centerIndex >= width) {
      neighbors.add(cells[centerIndex - width]);
    }
    if ((centerIndex % width) < width - 1) {
      neighbors.add(cells[centerIndex + 1]);
    }
    if (centerIndex + width < cells.length) {
      neighbors.add(cells[centerIndex + width]);
    }
    if ((centerIndex % width) > 0) {
      neighbors.add(cells[centerIndex - 1]);
    }
    return neighbors;
  }

  void _commitTransactions() {
    for (var c in cells) {
      c.commitPendingTransactions();
    }
  }
}
