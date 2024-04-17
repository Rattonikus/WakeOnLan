package controller.wol;
import java.io.IOException;

import model.wol.*;
public class Controller 
{
	public Controller()
	{
		
	}
	
	public void start()
	{
		Server myServer = new Server(1026, "My Macer");

		
		
		String test = "I should be the client + ";
		test += myServer.getResponse();
		
		
	}
		
	public String handleError(Exception error)
	{
		String errorMessage = "You encountered an error \n";
		errorMessage += error;
		System.out.println(errorMessage);
		return errorMessage;
	}
	public String handleError(String error)
	{
		String errorMessage = "You encountered an error \n";
		errorMessage += error;
		System.out.println(errorMessage);
		return errorMessage;
	}
	
	private void createLog(String toLog)
	{
		IOController.saveStringFile(this, "Logs", toLog, "WoLlog");
	}
}
