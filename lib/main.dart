// import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

import 'app/app.dart';
import 'src/rust/frb_generated.dart';

Future<void> main() async {
  if (!kIsWeb) {
    await RustLib.init();
  }

  // const key = String.fromEnvironment('ALPACA_KEY');
  // const secret = String.fromEnvironment('ALPACA_SECRET');
  // final channel = WebSocketChannel.connect(
  //   Uri.parse('wss://stream.data.alpaca.markets/v1beta3/crypto/us'),
  // );
  // channel.stream.listen((message) {
  //   debugPrint('FRAME: $message');
  //   if (message.toString().contains('authenticated')) {
  //     channel.sink.add(
  //       jsonEncode({
  //         'action': 'subscribe',
  //         'trades': ['BTC/USD'],
  //       }),
  //     );
  //   }
  // });
  // channel.sink.add(
  //   jsonEncode({'action': 'auth', 'key': key, 'secret': secret}),
  // );

  runApp(const ProviderScope(child: MyApp()));
}
