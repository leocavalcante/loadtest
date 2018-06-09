import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:angel_framework/angel_framework.dart';

main() async {
  final isolates = <Isolate>[];

  for (int i = 0; i < Platform.numberOfProcessors; i++) {
    isolates.add(await Isolate.spawn(start, i + 1));
  }

  await Future.wait(isolates.map((i) {
    final rcv = new ReceivePort();
    i.addOnExitListener(rcv.sendPort);
    return rcv.first;
  }));
}

void start(int id) async {
  final data = await new File('mockdata.json').readAsBytes();
  final app = new Angel()..lazyParseBodies = true;
  final http = new AngelHttp.custom(app, startShared, useZone: false);

  app.get('*', (req, ResponseContext res) {
    res.write(data);
    return false;
  });

  http.startServer('127.0.0.1', 8080);
}
