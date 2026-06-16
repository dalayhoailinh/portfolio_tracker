import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'app/app.dart';
import 'src/rust/frb_generated.dart';

Future<void> main() async {
  if (!kIsWeb) {
    await RustLib.init();
  }

  // final response = await http.get(uri);
  // debugPrint('STATUS = ${response.statusCode}');
  // debugPrint('BODY START = ${response.body.substring(0, 120)}');
  // final List<dynamic> rows = jsonDecode(response.body);
  // debugPrint('GOT ${rows.length} rows. First = ${rows.first}');

  runApp(const ProviderScope(child: MyApp()));
}
