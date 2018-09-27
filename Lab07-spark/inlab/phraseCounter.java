import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.spark.api.java.function.FlatMapFunction;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Encoders;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.SparkSession;
import static org.apache.spark.sql.functions.*;

public class phraseCounter {

	public static String getString( Row row, String string ){
		return (String)row.getAs( string );
	}
	public static void main(String[] args) {
		
		//Input dir - should contain all input json files
		String inputPath="/home/amayjain/TeachingAssistant/sparkInlab/newsdata"; //Use absolute paths 
		final String delimiter = "%";
		//Ouput dir - this directory will be created by spark. Delete this directory between each run
		String outputPath="/home/amayjain/TeachingAssistant/sparkInlab/output";   //Use absolute paths
		
		
		SparkSession sparkSession = SparkSession.builder()
				.appName("Month wise news articles")		//Name of application
				.master("local")								//Run the application on local node
				.config("spark.sql.shuffle.partitions","2")		//Number of partitions
				.getOrCreate();
		
		//Read multi-line JSON from input files to dataset
		Dataset<Row> inputDataset=sparkSession.read().option("multiLine", true).json(inputPath);   
		
		
		//Apply the flatMap function -- the FlatMapFunction call return an iterator 
		//Alternately the map function can be applied to return only the String
		Dataset<String> monthDataset=inputDataset.flatMap(new FlatMapFunction<Row,String>(){
			public Iterator<String> call(Row row) throws Exception {
				//The first 7 characters of date_published give the year-month 
				String source_name = getString( row, "source_name" );
				String words = getString( row, "article_body" );
				words = words.toLowerCase().replaceAll("[^A-Za-z]", " ").replaceAll("( )+", " ").trim(); 
			    List<String> wordList = Arrays.asList(words.split(" "));

				//Create an array and return the iterator
				return wordList.stream().map( x -> source_name + delimiter + x ).collect( Collectors.toList() ).iterator();	  
			}
			
		}, Encoders.STRING());
		
		
		//Alternative way use flatmap
		/*Dataset<String> monthDataset=inputDataset.flatMap(
				row-> {return Arrays.asList(((String)row.getAs("date_published")).substring(0, 7)).iterator();}, 
				Encoders.STRING());
		*/
		
		
		//The column name of the dataset returned is value, group by the column and take count
		Dataset<Row> count=monthDataset.groupBy("value").count();  
		count = count.withColumn( "split_temp", split( col("value"), delimiter ) ).select( 
				col( "split_temp" ).getItem( 0 ).as( "source" ),
				col( "split_temp" ).getItem( 1 ).as( "word" ),
				col( "count" )
			);
		
		//Outputs the dataset to the standard output
		//count.show();
		
		
		//Ouputs the result to a file
		count.toJavaRDD().saveAsTextFile(outputPath);	
		
	}
	
}
