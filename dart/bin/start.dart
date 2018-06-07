import 'dart:async';
import 'dart:io';

import 'package:start/start.dart';

Future main() async {
  final file = new File('mockdata.json');
  final data = await file.readAsString();

  final server = await start(port: 8080);
  server.get('/').listen((request) => request.response.send(data));
}
