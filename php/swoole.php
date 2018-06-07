<?php declare(strict_types=1);

$data = file_get_contents('mockdata.json');

$http = new swoole_http_server('127.0.0.1', 8080);

$http->on('request', function ($request, $response) use ($data) {
  $response->header('Content-Type', 'application/json');
  $response->end($data);
});

$http->start();
