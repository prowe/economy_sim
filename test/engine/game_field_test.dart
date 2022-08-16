import 'package:economy_sim/engine/game_cell.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:economy_sim/engine/game_field.dart';

@GenerateMocks([GameCell])
import 'game_field_test.mocks.dart';

void main() {
  test('The cycle should queue 10 sunlight', () {
    var cell = MockGameCell();
    var f = GameField(width: 1, cells: [cell]);
    f.executeCycle();

    verify(cell.queueTransaction('Sunlight', 10));
  });

  test('The cycle should executeCurrentRecipe', () {
    var cell = MockGameCell();
    var f = GameField(width: 1, cells: [cell]);
    f.executeCycle();

    verify(cell.executeCurrentRecipe());
  });

  test('The cycle should commitPendingTransactions', () {
    var cell = MockGameCell();
    var f = GameField(width: 1, cells: [cell]);
    f.executeCycle();

    verify(cell.commitPendingTransactions());
  });

  test('The cycle should pass all neighbors for a middle cell', () {
    var north = MockGameCell();
    var east = MockGameCell();
    var south = MockGameCell();
    var west = MockGameCell();
    var center = MockGameCell();
    var cells = [
      GameCell(),
      north,
      GameCell(),
      west,
      center,
      east,
      GameCell(),
      south,
      GameCell(),
    ];

    var f = GameField(width: 3, cells: cells);
    f.executeCycle();

    verify(center.conductInventoryToNeighbors([north, east, south, west]));
  });

  test('Should pass neghboring cells when in a corner', () {
    var northWest = MockGameCell();
    var northEast = MockGameCell();
    var southWest = MockGameCell();
    var southEast = MockGameCell();
    var cells = [northWest, northEast, southWest, southEast];
    var f = GameField(width: 2, cells: cells);

    f.executeCycle();

    verify(northWest.conductInventoryToNeighbors([northEast, southWest]));
    verify(northEast.conductInventoryToNeighbors([southEast, northWest]));
    verify(southEast.conductInventoryToNeighbors([northEast, southWest]));
    verify(southWest.conductInventoryToNeighbors([northWest, southEast]));
  });
}
