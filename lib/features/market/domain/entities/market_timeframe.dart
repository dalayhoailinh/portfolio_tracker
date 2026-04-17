enum MarketTimeframe {
  m1(label: 'm1', multiplier: 1),
  m5(label: 'm5', multiplier: 5),
  m15(label: 'm15', multiplier: 15),
  m30(label: 'm30', multiplier: 30),
  h1(label: 'h1', multiplier: 60);

  final String label;
  final int multiplier;

  const MarketTimeframe({required this.label, required this.multiplier});
}
