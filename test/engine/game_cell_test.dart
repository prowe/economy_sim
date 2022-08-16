import 'package:test/test.dart';
import 'package:economy_sim/engine/game_cell.dart';

void main() {
  const corn = 'Corn';

  group('queueTransaction', () {
    test('should not change current inventory', () {
      var cell = GameCell();
      cell.queueTransaction(corn, 1);
      expect(cell.getInventoryQuantity(corn), isZero);
    });
  });

  group('commitPendingTransactions', () {
    test('updates inventory', () {
      var cell = GameCell();
      cell.queueTransaction(corn, 1);
      cell.commitPendingTransactions();
      expect(cell.getInventoryQuantity(corn), equals(1));
    });
    test('adds to inventory that already exists', () {
      var cell = GameCell();
      cell.queueTransaction(corn, 1);
      cell.commitPendingTransactions();
      cell.queueTransaction(corn, 1);
      cell.commitPendingTransactions();
      expect(cell.getInventoryQuantity(corn), equals(2));
    });

    test('should not re-add if already committed', () {
      var cell = GameCell();
      cell.queueTransaction(corn, 1);
      cell.commitPendingTransactions();
      cell.commitPendingTransactions();
      expect(cell.getInventoryQuantity(corn), equals(1));
    });
  });

  group('getInventoryQuantity', () {
    test('should return 0 for an unknown inventory', () {
      var cell = GameCell();
      expect(cell.getInventoryQuantity(corn), isZero);
    });
    test('should return the inventory committed', () {
      var cell = GameCell();
      cell.queueTransaction(corn, 1);
      cell.commitPendingTransactions();
      expect(cell.getInventoryQuantity(corn), equals(1));
    });
  });
}
