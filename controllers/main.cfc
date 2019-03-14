
/**
* Main_Default Controller
* @file  controllers/main
* @author  David Fairfield (david.fairfield@gmail.com)
* @accessors true 
* @extends model.abstract.baseCONT
* */

component {
	

	// ------------------------ DEPENDENCY INJECTION ------------------------ //
		property parserService;
	// ------------------------ PUBLIC METHODS ------------------------ //

	/**
	* I am responsible for rerieving all Text files
	* @access public
	* @returntype void
	* @output false
	* 
	**/
		function default(required struct rc) {
			rc.dataFiles = variables.parserService.getDatafiles(rc.dataFilePath);
		}

	/**
	* I am responsible for parsing a file
	* @access public
	* @returntype void
	* @output false
	**/
		function parseFile(required struct rc) {
		 variables.ParserService.setupFileObject(rc.dataFilePath &  rc.dataFile);
		rc.results = [];
		var Process = true;
		
			do{
				var tmp = variables.parserService.getNextLineTokens();
				rc.results.append(tmp);
				if(!arraylen(tmp)) Process = false;
				
			}while( process );

		
		
		}

}

