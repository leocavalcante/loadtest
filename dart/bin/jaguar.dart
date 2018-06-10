import 'dart:io';
import 'dart:isolate';

import 'package:jaguar/jaguar.dart';

serve(_) async {
  final data = await new File('mockdata.json').readAsBytes();
  final server = new Jaguar(port: 8080, multiThread: true);

  server.get('*', (ctx) => ctx.response = new ByteResponse(data));
  server.serve();
}

main(List<String> args) async {
  final port = new ReceivePort();

  port.listen((e) {
    print('Isolate error: $e');
  });

  for (int i = 0; i < Platform.numberOfProcessors; i++) {
    await Isolate.spawn(serve, null, onError: port.sendPort);
  }
}
