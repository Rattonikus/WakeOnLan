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
		
	}
	
	
	
	
	public static String handleError(Exception e)
	{
		String errorMessage = "You encountered an error \n";
		errorMessage += e;
		return errorMessage;
	}
	
	public String handleError(String e)
	{
		String errorMessage = "You encountered an error \n";
		errorMessage += e;
		return errorMessage;
	}
}
