package socket.controller;

import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.io.InputStreamReader;
import java.io.BufferedReader;

public class Controller 
{
    public static void main(String[] args) throws IOException 
    {
        HttpServer server = HttpServer.create(new InetSocketAddress(8000), 0);
        server.createContext("/print", (exchange -> {
            if ("POST".equals(exchange.getRequestMethod())) {
                InputStreamReader isr = new InputStreamReader(exchange.getRequestBody(), "utf-8");
                BufferedReader br = new BufferedReader(isr);
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
                br.close();
                isr.close();
                String input = sb.toString();
                System.out.println("Received: " + input);
                String response = "Received: " + input;
                exchange.sendResponseHeaders(200, response.getBytes().length);
                OutputStream os = exchange.getResponseBody();
                os.write(response.getBytes());
                os.close();
            } else {
                exchange.sendResponseHeaders(405, 0); // Method Not Allowed
            }
        }));
        server.setExecutor(null);
        server.start();
        System.out.println("Java Server started on port 8000");
    }
}