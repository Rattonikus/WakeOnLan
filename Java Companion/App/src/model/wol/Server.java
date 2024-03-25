package model.wol;

import com.sun.net.httpserver.HttpServer;

import controller.wol.Controller;

import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.net.BindException;
import java.net.InetSocketAddress;
import java.io.InputStreamReader;
import java.io.BufferedReader;

public class Server 
{
	private Controller app;
	private String errorText;
	
	private HttpServer httpServer;
	private int port;
	private String name;
	private String clientResponse;
	
	
	public Server(int serverPort, String computerName)
	{
		app = new Controller();
		errorText = "";
		port = serverPort;
		name = computerName;
		clientResponse = "";
		
		try
		{
			httpServer = HttpServer.create(new InetSocketAddress(port), 0);
			startServer(httpServer);

		}
		catch (IOException e)
		{
			errorText += e;
			app.handleError(errorText);
		}
		
	}
	
	private void startServer(HttpServer server)
	{
		
		server.createContext("/WoL", (exchange ->
		{
			if ("POST".equals(exchange.getRequestMethod()))
			{
				InputStreamReader inputStream = new InputStreamReader(exchange.getRequestBody(), "utf-8");
				BufferedReader bufferedReader = new BufferedReader(inputStream);
				StringBuilder stringBuilder = new StringBuilder();
				String line; 
				
				while ((line = bufferedReader.readLine()) != null)
				{
					stringBuilder.append(line);
				}
			
				bufferedReader.close();
				inputStream.close();
				String input = stringBuilder.toString();

				clientResponse = input;
				System.out.println(input);
				String serverResponse = checkValid(input);
				exchange.sendResponseHeaders(200, serverResponse.getBytes().length);
					
				OutputStream outputStream = exchange.getResponseBody();
				outputStream.write(serverResponse.getBytes());
				outputStream.close();
				}
				else
				{
					exchange.sendResponseHeaders(405, 0);
					app.handleError("Method not allowed");
				}
			}));
		
		server.setExecutor(null);
		server.start();
        System.out.println("Java Server started on portt " + port);

	}
	
	private String checkValid(String response)
	{
		String validResponse = response + "-" + name;
		
		return validResponse;
	}
	
	public String getResponse()
	{
		return clientResponse;
	}
}
