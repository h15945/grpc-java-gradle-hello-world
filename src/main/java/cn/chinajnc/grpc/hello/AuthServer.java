package cn.chinajnc.grpc.hello;


import io.grpc.Server;
import io.grpc.ServerBuilder;
import io.grpc.stub.StreamObserver;

import java.util.Arrays;
import java.util.logging.Logger;

import static io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall;

public class AuthServer {

    private static final Logger logger = Logger.getLogger(AuthServer.class.getName());

    private int port = 50051;
    private Server server;

    private void start() throws Exception {
        logger.info("Starting the grpc server");

        server = ServerBuilder.forPort(port)
                .addService(new AuthImpl())
                .build()
                .start();

        logger.info("Server started. Listening on port " + port);

        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            System.err.println("*** JVM is shutting down. Turning off grpc server as well ***");
            AuthServer.this.stop();
            System.err.println("*** shutdown complete ***");
        }));
    }

    private void stop() {
        if (server != null) {
            server.shutdown();
        }
    }


    public static void main(String[] args) throws Exception {
        logger.info("Server startup. Args = " + Arrays.toString(args));
        final AuthServer helloWorldServer = new AuthServer();

        helloWorldServer.start();
        helloWorldServer.blockUntilShutdown();
    }

    private void blockUntilShutdown() throws InterruptedException {
        if (server != null) {
            server.awaitTermination();
        }
    }

    private class AuthImpl extends AuthGrpc.AuthImplBase {

        @Override
        public void configAuth(AuthRequest request,StreamObserver<AuthResponse> responseObserver) {
            System.out.println("username  is :" + request.getUsername() + " password  is :" + request.getUserpasd() );
            AuthResponse response = AuthResponse.newBuilder().setErrorcode(0).setMessages("wahaha").build();
            responseObserver.onNext(response);
            responseObserver.onCompleted();
        }
    }
}
