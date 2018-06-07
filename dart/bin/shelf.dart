import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

Future main() async {
  final file = new File('mockdata.json');
  final data = await file.readAsString();
  final handler = (request) => new Response.ok(data);

  await io.serve(handler, '0.0.0.0', 8080);
}