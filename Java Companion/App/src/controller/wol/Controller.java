package controller.wol;
import model.wol.*;
public class Controller 
{
	public Controller()
	{
		
	}
	
	public void start()
	{
		Server myServer = new Server(8080, "My Mac");
		String test = "I should be the client + ";
		test += myServer.getResponse();
		
	}
		
	public String handleError(String e)
	{
		String errorMessage = "You encountered an error \n";
		errorMessage += e;
		System.out.println(errorMessage);
		return errorMessage;
	}
}
