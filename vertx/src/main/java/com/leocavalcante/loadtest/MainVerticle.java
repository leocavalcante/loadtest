package com.leocavalcante.loadtest;

import io.vertx.core.AbstractVerticle;

public class MainVerticle extends AbstractVerticle {

    @Override
    public void start() throws Exception {
        vertx.fileSystem().readFile("mockdata.json", data -> {
            vertx.createHttpServer().requestHandler(req -> {
                req.response().end(data.result());
            }).listen(8080);
        });
    }
}
