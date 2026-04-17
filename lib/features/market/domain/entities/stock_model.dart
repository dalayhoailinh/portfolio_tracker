import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_model.freezed.dart';
part 'stock_model.g.dart';

@freezed
abstract class StockModel with _$StockModel {
  const factory StockModel({
    required String symbol,
    required String name,
    required double price,
    required double seedPrice,
    @Default(0.0) double changePercent,
  }) = _StockModel;

  factory StockModel.fromJson(Map<String, dynamic> json) =>
      _$StockModelFromJson(json);
}

const List<StockModel> kSeedStocks = [
  StockModel(
    symbol: 'AAPL',
    name: 'Apple Inc.',
    price: 178.50,
    seedPrice: 178.50,
  ),
  StockModel(
    symbol: 'GOOGL',
    name: 'Alphabet Inc.',
    price: 140.20,
    seedPrice: 140.20,
  ),
  StockModel(
    symbol: 'MSFT',
    name: 'Microsoft Corp.',
    price: 415.80,
    seedPrice: 415.80,
  ),
  StockModel(
    symbol: 'TSLA',
    name: 'Tesla Inc.',
    price: 195.30,
    seedPrice: 195.30,
  ),
  StockModel(
    symbol: 'NVDA',
    name: 'NVIDIA Corp.',
    price: 875.60,
    seedPrice: 875.60,
  ),
];
