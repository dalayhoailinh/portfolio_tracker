import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/position.dart';

part 'position_dto.freezed.dart';
part 'position_dto.g.dart';

@freezed
abstract class PositionDto with _$PositionDto {
  const PositionDto._();
  const factory PositionDto({
    required String symbol,
    required double quantity,
    required double avgBuyPrice,
  }) = _PositionDto;

  factory PositionDto.fromJson(Map<String, dynamic> json) =>
      _$PositionDtoFromJson(json);

  factory PositionDto.fromEntity(Position entity) {
    return PositionDto(
      symbol: entity.symbol,
      quantity: entity.quantity,
      avgBuyPrice: entity.avgBuyPrice,
    );
  }

  Position toEntity() {
    return Position(
      symbol: symbol,
      quantity: quantity,
      avgBuyPrice: avgBuyPrice,
    );
  }
}
