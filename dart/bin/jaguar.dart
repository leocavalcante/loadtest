import 'dart:io';
import 'dart:isolate';
import 'dart:convert';
import 'package:jaguar/jaguar.dart';

serve(_) async {
  final payloadFile = new File('mockdata.json');
  final payload = await payloadFile.readAsString();
  final bytes = utf8.encode(payload);

  final server = new Jaguar(port: 8080, multiThread: true);
  server.get('*', (ctx) => ctx.response = new ByteResponse(bytes));
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
