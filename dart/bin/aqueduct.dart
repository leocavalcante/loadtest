import 'dart:async';
import 'dart:io';

import 'package:aqueduct/aqueduct.dart';

class Sink extends RequestSink {
  String data;

  Sink(ApplicationConfiguration config) : super(config);

  @override
  Future willOpen() async {
    data = await new File('mockdata.json').readAsString();
  }

  @override
  void setupRouter(Router router) {
    router.route('*').listen(
        (request) => new Response(200, {'Content-Type': 'text/plain'}, data));
  }
}

main() {
  final app = new Application<Sink>()..configuration.port = 8080;
  app.start(numberOfInstances: Platform.numberOfProcessors);
}
