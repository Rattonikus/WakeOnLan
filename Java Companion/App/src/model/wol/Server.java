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

public class Server 	//Server object
{
	//Defining data members
	private Controller app;
	private String errorText;
	private HttpServer httpServer;
	private int port;
	private String name;
	private String clientResponse;
	
	
	public Server(int serverPort, String computerName)	//Server constructor 
	{
		app = new Controller();		//Initialize our data members
		errorText = "";
		port = serverPort;
		name = computerName;
		clientResponse = "";
		
		try		//Try creating server object
		{
			httpServer = HttpServer.create(new InetSocketAddress(port), 0);
			startServer(httpServer);

		}
		catch (IOException e)	//catches err (is port in use?)
		{
			errorText += e;
			app.handleError(errorText);
		}
		
	}
	
	private void startServer(HttpServer server)	//Start our server
	{
		
		server.createContext("/WoL", (exchange -> handleExchange(exchange))); //Creates context, maps URI path to WoL, handles exchange with the listed method
		server.setExecutor(null);
		server.start();
        System.out.println("Java Server started on portt " + port); //Lets you know the server has begun

	}
	
	private String checkValid(String response) //TODO: Check if client is a valid WoL client, not yet implemented. I'll figure this out soon. 
	{
		String validResponse = response + "-" + name;
		
		return validResponse;
	}
	
	public String getResponse() //Response Getter
	{
		return clientResponse;
	}
	
	public void handleExchange(HttpExchange exchange) throws IOException		//Handle our exchange
	{
		if ("POST".equals(exchange.getRequestMethod()))		//If client is requests via POST...
		{
			InputStreamReader inputStream = new InputStreamReader(exchange.getRequestBody(), "utf-8"); //Create our nessecary reading/writing tools
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
		
	}
	
	
}
