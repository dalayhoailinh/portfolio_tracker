import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/stock_model.dart';

part 'stock_dto.freezed.dart';
part 'stock_dto.g.dart';

@freezed
abstract class StockDto with _$StockDto {
  const StockDto._();
  const factory StockDto({
    required String symbol,
    required String name,
    required double price,
    required double seedPrice,
    @Default(0.0) double changePercent,
  }) = _StockDto;

  factory StockDto.fromJson(Map<String, dynamic> json) =>
      _$StockDtoFromJson(json);

  factory StockDto.fromEntity(StockModel entity) {
    return StockDto(
      symbol: entity.symbol,
      name: entity.name,
      price: entity.price,
      seedPrice: entity.seedPrice,
      changePercent: entity.changePercent,
    );
  }

  StockModel toEntity() {
    return StockModel(
      symbol: symbol,
      name: name,
      price: price,
      seedPrice: seedPrice,
      changePercent: changePercent,
    );
  }
}
