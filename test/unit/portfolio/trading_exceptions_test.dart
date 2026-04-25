import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_tracker/features/portfolio/domain/entities/trading_exception.dart';

void main() {
  test('InsufficientCashException shows need and have amounts', () {
    final e = InsufficientCashException(required: 1500, available: 999.12);
    expect(e.toString(), contains('1500.00'));
    expect(e.toString(), contains('999.12'));
    expect(e.toString(), contains('No enough cash'));
  });

  test('PositionNotFoundException includes symbol', () {
    final e = PositionNotFoundException('XYZ');
    expect(e.toString(), contains('XYZ'));
  });

  test('InsufficientQuantityException shows requested and available', () {
    final e = InsufficientQuantityException(requested: 10, available: 3);
    expect(e.toString(), contains('10.00'));
    expect(e.toString(), contains('3.00'));
  });

  test('InvalidQuantityException mentions zero guard', () {
    expect(InvalidQuantityException().toString(), contains('greater than 0'));
  });
}
