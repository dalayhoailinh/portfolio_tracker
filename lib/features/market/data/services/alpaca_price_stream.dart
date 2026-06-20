import 'dart:async';
import 'dart:convert';

import '../../../../app/api_config.dart';
import '../../domain/entities/live_tick.dart';
import '../../domain/entities/market_data_exception.dart';
import '../../domain/repositories/i_live_price_source.dart';
import 'alpaca_frame_parser.dart';
import 'text_socket.dart';
import 'web_socket_text_socket.dart';

class AlpacaPriceStream implements ILivePriceSource {
  final TextSocket Function() _openSocket;
  final String _key;
  final String _secret;

  AlpacaPriceStream({
    TextSocket Function()? openSocket,
    String? key,
    String? secret,
  }) : _openSocket =
           openSocket ??
           (() => WebSocketTextSocket(Uri.parse(ApiConfig.alpacaCryptoWsUrl))),
       _key = key ?? ApiConfig.alpacaKey,
       _secret = secret ?? ApiConfig.alpacaSecret;

  @override
  Stream<LiveTick> watchTrades(List<String> symbols) {
    final socket = _openSocket();
    late final StreamController<LiveTick> controller;
    late final StreamSubscription<String> sub;

    void onFrame(String raw) {
      if (AlpacaFrameParser.isAuthenticated(raw)) {
        socket.send(jsonEncode({'action': 'subscribe', 'trades': symbols}));
        return;
      }
      try {
        for (final tick in AlpacaFrameParser.parseTrades(raw)) {
          controller.add(tick);
        }
      } on MarketDataException catch (e) {
        controller.addError(e);
      }
    }

    controller = StreamController<LiveTick>(
      onListen: () {
        sub = socket.messages.listen(
          onFrame,
          onError: (Object e) => controller.addError(
            LiveStreamException('Live stream dropped: $e'),
          ),
          onDone: controller.close,
        );
        socket.send(
          jsonEncode({'action': 'auth', 'key': _key, 'secret': _secret}),
        );
      },
      onCancel: () async {
        await sub.cancel();
        await socket.close();
      },
    );

    return controller.stream;
  }
}
