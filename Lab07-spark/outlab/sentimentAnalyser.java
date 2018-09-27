import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

import org.apache.spark.api.java.function.FlatMapFunction;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.RowFactory;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.functions;
import org.apache.spark.sql.catalyst.encoders.ExpressionEncoder;
import org.apache.spark.sql.catalyst.encoders.RowEncoder;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.StructType;


public class sentimentAnalyser {
	public static void main(String[] args) {
		
		//Input dir - should contain all input json files
		String inputPath = "/home/amayjain/TeachingAssistant/sparkOutLab/outlab/input/newsdata"; //Use absolute paths
		String entitiesPath = "/home/amayjain/TeachingAssistant/sparkOutLab/outlab/input/entities.txt";
		String positivesPath = "/home/amayjain/TeachingAssistant/sparkOutLab/outlab/input/positive-words.txt";
		String negativesPath = "/home/amayjain/TeachingAssistant/sparkOutLab/outlab/input/negative-words.txt";
		String outputPath = "/home/amayjain/TeachingAssistant/sparkOutLab/outlab/output";   //Use absolute paths
		
		StructType structType = new StructType();
	    structType = structType.add( "source", DataTypes.StringType, false); // false => not nullable
	    structType = structType.add( "year_month", DataTypes.StringType, false); // false => not nullable
	    structType = structType.add( "entity", DataTypes.StringType, false); // false => not nullable
	    structType = structType.add( "sentiment", DataTypes.IntegerType, false); // false => not nullable
	    ExpressionEncoder<Row> sourceRowEncoder = RowEncoder.apply(structType);
	    
	    HashSet<String> entities = new HashSet<>();
		try {
			Scanner scanner = new Scanner(new File(entitiesPath));
			while(scanner.hasNext()) {
				entities.add(scanner.next());
			}
			scanner.close();
		}
		catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HashSet<String> positiveWords = new HashSet<>();
		try {
			Scanner scanner = new Scanner(new File(positivesPath));
			while(scanner.hasNext()) {
				positiveWords.add(scanner.next());
			}
			scanner.close();
		}
		catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HashSet<String> negativeWords = new HashSet<>();
		try {
			Scanner scanner = new Scanner(new File(negativesPath));
			while(scanner.hasNext()) {
				negativeWords.add(scanner.next());
			}
			scanner.close();
		}
		catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
				
		SparkSession sparkSession = SparkSession.builder()
				.appName("Sentiment Analyser")		//Name of application
				.master("local")								//Run the application on local node
				.config("spark.sql.shuffle.partitions","2")		//Number of partitions
				.getOrCreate();
		
		//Read multi-line JSON from input files to dataset
		Dataset<Row> inputDataset=sparkSession.read().option("multiLine", true).json(inputPath);   
		
		// Apply the map function to extract the source_name
		Dataset<Row> sentimentData = inputDataset.flatMap(new FlatMapFunction<Row,Row>(){
			public Iterator<Row> call(Row row) throws Exception {
				// The first 7 characters of date_published gives the year-month 
				String source = ((String)row.getAs("source_name"));
				String yearMonthPublished = ((String)row.getAs("date_published")).substring(0, 7);
				String words = ((String)row.getAs("article_body"));
				ArrayList<Row> rowList = new ArrayList<>();
				words = words.toLowerCase().replaceAll("[^A-Za-z]", " ").replaceAll("( )+", " ").trim(); 
			    List<String> wordList = Arrays.asList(words.split(" "));
				
				for(int i=0; i<wordList.size();i++) {
					String word = wordList.get(i);
					if(entities.contains(word)) {
						Boolean flag = false;
						for(int j = Math.max( i-5, 0 ); j < Math.min( i+6, wordList.size() ); j++ ) {
							String sentiment = wordList.get(j);
							if(positiveWords.contains(sentiment)) {
								rowList.add(RowFactory.create(source, yearMonthPublished, word, +1));
								flag = true;
							}
							else if(negativeWords.contains(sentiment)) {
								rowList.add(RowFactory.create(source, yearMonthPublished, word, -1));
								flag = true;
							}
						}
						if(!flag)
							rowList.add(RowFactory.create(source, yearMonthPublished, word, 0));
					}
				}

				return rowList.iterator();	  
  
			}
			
		}, sourceRowEncoder);
		
		//Alternative way use flatmap using lambda function
		/*Dataset<String> yearMonthDataset=inputDataset.map(
				row-> {return ((String)row.getAs("date_published")).substring(0, 7);}, 
						Encoders.STRING());
		*/
		
		
		//The column name of the dataset for string encoding is value
		// Group by the desired column(s) and take count. groupBy() takes 1 or more parameters
		//Rename the result column as year_month_count
		Dataset<Row> cntDataset = sentimentData
				.groupBy("source","year_month","entity","sentiment")
				.count()
				.as("count");
//		cntDataset.printSchema();
		Dataset<Row> overallDataset = cntDataset
				.groupBy("source","year_month","entity")
				.agg(
						functions.sum(cntDataset.col("sentiment").multiply(cntDataset.col("count")))
						.as("overall_sentiment"),
						functions.sum("count")
						.as("support")
				);
		
		Dataset<Row> finDataset = overallDataset
				.select("source","year_month","entity","overall_sentiment")
				.where("support>=5")
				.orderBy(functions.abs(overallDataset.col("overall_sentiment")).desc()); 
		
		//Ouputs the result to a file
		finDataset.toJavaRDD().saveAsTextFile(outputPath);	
		
	}
}
