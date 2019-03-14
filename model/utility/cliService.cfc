/**
*
* @file  model/utiltiy/cliService.cfc
* @author  David Fairfield (david.fairfield@gmail.com)
* */
component {

// ------------------------ PUBLIC METHODS ------------------------ //
	/**
	* I am responsible for executing the specified system command and returns a struct with the results.
	* @access public
	* @returntype struct
	* @output false
	**/
		function execute(required string command){
			var cmd = arguments.command;
			var process = 0;
			var result = structNew();
			result.command = cmd;
			result.executeError = "";
			result.standardOutput = "";
			result.errorOutput = "";
			try{
				process = getRuntime().exec(cmd);
				result.standardOutput = getOutput(process.getInputStream());
				result.errorOutput = getOutput(process.getErrorStream());
				}catch(any e){
					result.executeError = e;
				}
			
			return result;
		}
	
	/**
	* I am responsible for returning the Runtime object which allows commands to be executed.
	* @access private
	* @returntype any
	* @output false
	**/
		function getRuntime(){
			return createObject("java", "java.lang.Runtime").getRuntime();
		}

	/**
	* I am responsible for reading the data stream and returns a string. 
	* Assumes the stream is lines of string data.
	* @access private
	* @returntype string
	* @output false
	**/
		function getoutput(required any outputStream){
			var newline = getNewlineChar();
			var bufReader = newBufferedReader(arguments.outputStream);
			var bufString = newStringBuffer();
			var line = "";
			var exitLoop = false;

			do{
				line = bufReader.readLine();

				if(!structkeyExists(local,'line')){
					break;
				}
				
				bufString.append(line);
				bufString.append(newline);
			}while(true);

			return bufString.toString();

		}
	
	/**
	* I am responsible for returning the system newline character
	* @access private
	* @returntype any
	* @output false
	**/
		function getNewLineChar(){
			return createObject("java", "java.lang.System").getProperty("line.separator");
		}
	
	/**
	* I am responsible for returning a java stringbuffer object.
	* @access private
	* @returntype any
	* @output false
	**/
		function newStringBuffer(){
			return createObject("java", "java.lang.StringBuffer");
		}

	/**
	* I am responsible for Returns a buffered reader for a specified stream. 
	* This allows us to read lines of data returned from the stream.
	* @access private
	* @returntype any
	* @output false
	**/
		function newBufferedReader(required any stream){
			var streamReader = createObject("java", "java.io.InputStreamReader").init(arguments.stream);
			var buffererdReader = createObject("java", "java.io.BufferedReader").init(streamReader);
			return buffererdReader;
		}

	
}