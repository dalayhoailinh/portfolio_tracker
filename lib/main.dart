import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'src/rust/frb_generated.dart';

Future<void> main() async {
  if (!kIsWeb) {
    await RustLib.init();
  }
  runApp(const ProviderScope(child: MyApp()));
}
