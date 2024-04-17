package controller.wol;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Scanner;

public class IOController 
{
	public static void saveStringFile(Controller app, String path, String toSave, String name)
	{
		String filename = path; 
		LocalDateTime date = LocalDateTime.now();
		filename += "/" + date.getMonthValue() + "-" + date.getDayOfMonth();
		filename += name; 
		
		File saveFile = new File(filename);
		
		try(FileOutputStream fileOutput = new FileOutputStream(saveFile, true); Scanner textScanner = new Scanner(toSave))
		{
			while (textScanner.hasNext())
			{
				String currentLine = textScanner.nextLine() + "\n";
				byte[] currentLineAsByte = currentLine.getBytes();
				fileOutput.write(currentLineAsByte);
			}
		}
		catch(IOException error)
		{
			app.handleError(error);
		}
		catch(Exception error)
		{
			app.handleError(error);
		}
	}

}
