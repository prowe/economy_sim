import 'dart:ffi';

class GameCell {
  final List<_GameCellQueuedTransaction> _transactionQueue = [];
  final Map<String, int> _inventory = {};

  void queueTransaction(String material, int quantity) {
    _transactionQueue.add(_GameCellQueuedTransaction(material, quantity));
  }

  void commitPendingTransactions() {
    for (var trans in _transactionQueue) {
      var currentQuantity = getInventoryQuantity(trans.material);
      _inventory[trans.material] = currentQuantity + trans.quantity;
    }
    _transactionQueue.clear();
  }

  int getInventoryQuantity(String material) {
    return _inventory[material] ?? 0;
  }

  void executeCurrentRecipe() {}

  void conductInventoryToNeighbors(List<GameCell> neighbors) {}
}

class _GameCellQueuedTransaction {
  final int quantity;
  final String material;

  _GameCellQueuedTransaction(this.material, this.quantity);
}
