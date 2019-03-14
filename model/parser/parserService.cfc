
/**
*	Parser Service Layer
* @file  model.parser.parserService
* @author  David Fairfield (david.fairfield@gmail.com)
* @accessors true 
* @extends model.abstract.baseSVC
* */
component {

	// ------------------------ PUBLIC METHODS ------------------------ //
	/**
	* I am responsible for setting up fileObject for parsing
	* @access public
	* @returntype boolean
	* @output false
	**/

        function setupFileObject( required string fileToProcess, array fixedLen = []) {

            variables.delimiter = "unknown";
            variables.fixedLen	= [];
            variables.fileObj = "";

            // check to see if file exists, if not exit nothing more to do
            if(!FileExists(arguments.fileToProcess)) return false; 


            // Load the fileOject, this is 100% not thread safe but will do for demo purposes.
            variables.fileObj = FileOpen(arguments.fileToProcess); 

            local.fileExtDelim = "."; 

            switch(arguments.fileToProcess.listlast(local.fileExtDelim))	{
                case "tab": {  
                    variables.delimiter = Chr(9); 	// Set the delimited to Tab
                    break; 
                }
                case "csv": {  
                    variables.delimiter = ",";		// Set the delimited to CSV
                    break; 
                }
                   
                case "pipe": {
                    variables.delimiter = "|";		// Set the delimited to Pipe
                    break; 
                }
                 default: {
                    variables.delimiter = "unknown"; 
                    return false; 
                    break;
                }
            }

            return true;
        }

	// ------------------------ PUBLIC METHODS ------------------------ //
	/**
	* I am responsible for returning the next line tokens as an array
	* @access public
	* @returntype array
	* @output false
	**/
        function getNextLineTokens(){
            // if we are at the end of the file, return empty array
            if(FileisEOF(variables.fileObj)) return [];
        
            return FileReadLine(variables.fileObj).ListToArray(variables.delimiter);
        }

	/**
	* I am responsible for returning an array datafiles
	* @access public
	* @returntype array
	* @output false
	**/
        function getDataFiles(required string dataFilePath){
            // get the list of data files that can be parsed
            var tmpFileList = variables.directoryService.getDirectory(path: arguments.dataFilePath);
            var results = [];
            // add data file to results array
            for(var thisFile in tmpFileList) results.append(thisFile.filename);

            return results;
        }

}
