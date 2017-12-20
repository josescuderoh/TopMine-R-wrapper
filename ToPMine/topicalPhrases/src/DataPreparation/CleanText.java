package DataPreparation;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.text.Normalizer;
import java.nio.charset.StandardCharsets;

public class CleanText{
	/**
	 * @param args
	 * @throws IOException 
	 * @throws ClassNotFoundException 
	 */
	
	//usage: PrepareData [inputfile][lang] [swFile]
	
	public static void main(String[] args) throws IOException, ClassNotFoundException {
		long tStart = System.currentTimeMillis();

	//all parameters
		//ap dataset 2248 documents
		String inputFile = "../rawFiles/mod.txt"; // raw test input file
		String lang = "es";
		String swFile = "stoplists/en.txt";
		
		if(args.length >= 1){ inputFile = args[0];}
		if(args.length >= 2){ lang = args[1];}
		if(args.length >= 3){ swFile = args[2];}
		
		String sCurrentLine = null;
		BufferedReader br = null;
		
		br = new BufferedReader(new FileReader(swFile));
		String pat = "foo";
		while ((sCurrentLine = br.readLine()) != null){
			//Process line
			sCurrentLine = sCurrentLine.replaceAll("\n","");
			pat = pat+"|"+sCurrentLine;
		}
		br.close();
		
	//the files for output
		String outputFile ="rawFiles/cleanText";
		
	//first, partition the documents
		BufferedWriter wr = null;
		
		br = new BufferedReader(new FileReader(inputFile));
		wr = new BufferedWriter(new FileWriter(outputFile));
		String tmpLine;
		System.out.println("Cleaning text...");
		Pattern p = Pattern.compile("\\b("+pat+")\\b\\s?");
		
		int docid = 0;
		while ((sCurrentLine = br.readLine()) != null){
			//Start processing
			tmpLine = sCurrentLine;
			tmpLine = tmpLine.replaceAll("<.*?>", ""); //Remove all graphical symbols
			tmpLine = tmpLine.toLowerCase(); //Convert to lower case
			//Remove stopwords
			Matcher m = p.matcher(tmpLine);
			tmpLine = m.replaceAll("");
			//More processing
			tmpLine = tmpLine.replaceAll("\n", " "); //remove return marks
			if(lang.equals("es")){
				tmpLine = stripAccents(tmpLine);  //Strip accents
			}
			tmpLine = tmpLine.replaceAll("@\\w+", ""); //Remove users
			tmpLine = tmpLine.replaceAll("#\\w+", ""); //Remove hashtags
			tmpLine = tmpLine.replaceAll("\\p{Punct}+", ""); //Remove punctuation symbols
			tmpLine = tmpLine.replaceAll("[¿?]",""); //Remove question marks
			tmpLine = tmpLine.replaceAll("http\\w+", ""); //Remove https
			tmpLine = tmpLine.replaceAll("\\d"," ");  //Remove digits
			tmpLine = tmpLine.replaceAll("\\s+", " "); //Strip extra white spaces
			wr.write(tmpLine + "\n");
			docid ++;
		}
		br.close();
		wr.close();
		System.out.println("Done cleaning text...");
        
        long tEnd = System.currentTimeMillis();
        long tDelta = tEnd - tStart;
        double elapsedSeconds = tDelta / 1000.0;
        System.out.println("Time used: " + elapsedSeconds);
	}
	
	public static String removeEmojis(String input) {
		if (input == null) return null;
		StringBuilder sb = new StringBuilder();

		for (int i = 0; i < input.length(); i++) {
		  if (i < (input.length() - 1)) { // Emojis are two characters long in java, e.g. a rocket emoji is "\uD83D\uDE80";
			if (Character.isSurrogatePair(input.charAt(i), input.charAt(i + 1))) {
			  i += 1; //also skip the second character of the emoji
			  continue;
			}
		  }
		  sb.append(input.charAt(i));
		}
		return sb.toString();
	}
	
	public static String stripAccents(String s) 
{
    s = Normalizer.normalize(s, Normalizer.Form.NFD);
    s = s.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");
    return s;
}
}