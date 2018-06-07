<?php declare(strict_types=1);

require_once __DIR__.'/vendor/autoload.php';

$data = file_get_contents('mockdata.json');

$loop = React\EventLoop\Factory::create();

$server = new React\Http\Server(function (Psr\Http\Message\ServerRequestInterface $request) use ($data) {
    return new React\Http\Response(
        200,
        array('Content-Type' => 'application/json'),
        $data
    );
});

$socket = new React\Socket\Server(8080, $loop);
$server->listen($socket);

$loop->run();
