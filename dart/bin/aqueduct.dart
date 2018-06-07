import 'dart:async';
import 'dart:io';

import 'package:aqueduct/aqueduct.dart';

class Sink extends RequestSink {
  String data;

  Sink(ApplicationConfiguration config) : super(config);

  @override
  Future willOpen() async {
    final file = new File('mockdata.json');
    data = await file.readAsString();
  }

  @override
  void setupRouter(Router router) {
    router.route('/').listen((request) => new Response.ok(data));
  }
}

Future main() async {
  final app = new Application<Sink>()..configuration.port = 8080;
  await app.start(numberOfInstances: Platform.numberOfProcessors);
}
