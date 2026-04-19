class InsufficientCashException implements Exception {
  final double required;
  final double available;

  InsufficientCashException({required this.required, required this.available});

  @override
  String toString() =>
      'No enough cash: need \$${required.toStringAsFixed(2)}'
      ' have \$${available.toStringAsFixed(2)}';
}

class PositionNotFoundException implements Exception {
  final String symbol;

  PositionNotFoundException(this.symbol);

  @override
  String toString() => 'No position found for $symbol';
}

class InsufficientQuantityException implements Exception {
  final double requested;
  final double available;

  InsufficientQuantityException({
    required this.requested,
    required this.available,
  });

  @override
  String toString() =>
      'Cannot withdraw ${requested.toStringAsFixed(2)}'
      ': only ${available.toStringAsFixed(2)} available';
}

class InvalidQuantityException implements Exception {
  @override
  String toString() => 'Quantity must be greater than 0';
}
