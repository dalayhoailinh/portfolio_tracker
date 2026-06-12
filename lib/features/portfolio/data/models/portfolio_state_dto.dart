import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/portfolio_state.dart';
import 'position_dto.dart';

part 'portfolio_state_dto.freezed.dart';
part 'portfolio_state_dto.g.dart';

@freezed
abstract class PortfolioStateDto with _$PortfolioStateDto {
  const PortfolioStateDto._();
  const factory PortfolioStateDto({
    required double cash,
    required double realizedPnL,
    required double unrealizedPnL,
    @Default({}) Map<String, PositionDto> positions,
  }) = _PortfolioStateDto;

  factory PortfolioStateDto.fromJson(Map<String, dynamic> json) =>
      _$PortfolioStateDtoFromJson(json);

  factory PortfolioStateDto.fromEntity(PortfolioState entity) {
    return PortfolioStateDto(
      cash: entity.cash,
      realizedPnL: entity.realizedPnL,
      unrealizedPnL: entity.unrealizedPnL,
      positions: entity.positions.map(
        (key, value) => MapEntry(key, PositionDto.fromEntity(value)),
      ),
    );
  }

  PortfolioState toEntity() {
    return PortfolioState(
      cash: cash,
      realizedPnL: realizedPnL,
      unrealizedPnL: unrealizedPnL,
      positions: positions.map((key, value) => MapEntry(key, value.toEntity())),
    );
  }
}
