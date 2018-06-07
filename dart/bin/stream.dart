import 'dart:async';
import 'dart:io';

import 'package:stream/stream.dart';

Future main() async {
  final file = new File('mockdata.json');
  final data = await file.readAsString();

  new StreamServer(uriMapping: {
    '/': (HttpConnect connect) => connect.response.write(data)
  }).start(port: 8080);
}
