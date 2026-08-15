class FoodOrder {
  final int? id;
  final String itemName;
  final int quantity;

  const FoodOrder({
    this.id,
    required this.itemName,
    required this.quantity,
  });

  // Convert object into Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item_name': itemName,
      'quantity': quantity,
    };
  }

  // Convert SQLite Map into FoodOrder object
  factory FoodOrder.fromMap(Map<String, dynamic> map) {
    return FoodOrder(
      id: map['id'] as int?,
      itemName: map['item_name'] as String,
      quantity: map['quantity'] as int,
    );
  }
}