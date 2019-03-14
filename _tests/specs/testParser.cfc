
component extends="testbox.system.BaseSpec"{
/**
* Parser Unit Tests
* @file  _tests/specs/testParser.cfc
* @author  David Fairfield (david.fairfield@gmail.com)
* 
* */
	/**
	* I execute before all suites
	* @access public
	* @returntype any
	* @output false
	**/
		function beforeAll(){
			loc={
				mockbox = new testbox.system.MockBox(),
				parserService =  new model.parser.parserService(),
				tabFile = expandPath('/_datafiles/demofile.tab'),
				csvFile = expandPath('/_datafiles/demofile.csv'),
				pipeFile = expandPath('/_datafiles/demofile.pipe')
			};
		// ------------------------ DEPENDENCY INJECTION ------------------------ //
			loc.parserService.setBeanFactory(request.BeanFactory);
			loc.parserService.setDirectoryService(request.BeanFactory.getBean('directoryService'));
		}

	/**
	* I execute after all suites
	* @access public
	* @returntype any
	* @output false
	**/
		function afterAll(){}

	/**
	* I am responsible for running all test suites
	* @access public
	* @returntype any
	* @output false
	**/
	    function run( testResults, testBox ){
			
		// Start get{PLURAL}() Unit Test
		/** 
		* describe() starts a suite group of spec tests.
		* Arguments:
		* @title The title of the suite, Usually how you want to name the desired behavior
		* @body A closure that will resemble the tests to execute.
		* @labels The list or array of labels this suite group belongs to
		* @asyncAll If you want to parallelize the execution of the defined specs in this suite group.
		* @skip A flag that tells TestBox to skip this suite group from testing if true
		*/
		describe( "A TAB Parser spec", function(){
		
			// before each spec in THIS suite group
			beforeEach(function(){
				loc.parserService.setupFileObject(loc.tabFile);
				
			});
			
			// after each spec in THIS suite group
			afterEach(function(){
				
			});
			
			/** 
			* it() describes a spec to test. Usually the title is prefixed with the suite name to create an expression.
			* Arguments:
			* @title The title of the spec
			* @spec A closure that represents the test to execute
			* @labels The list or array of labels this spec belongs to
			* @skip A flag that tells TestBox to skip this spec from testing if true
			*/
			it("can open a text file and read the first line", function(){
 
				expect(loc.parserService).toBeComponent();
				results = loc.parserService.getNextLineTokens();
				expect(results).toBeArray();
				expect(results[1]).NottoBe('tab');
				expect(results[2]).toBe('is');
				expect(results[3]).toBe('a');
				expect(results[4]).toBe('tab');
			
			});
			
			// more than 1 expectation
			it("can open a text file and read the second line", function(){
			
				results = loc.parserService.getNextLineTokens();
				results = loc.parserService.getNextLineTokens();
				expect(results).toBeArray();
				expect(results[2]).toBe('green');
				expect(results[1]).nottoBe('green');
			});

			// negations
			it("can open a text file and read the third line", function(){
				results = loc.parserService.getNextLineTokens();
				results = loc.parserService.getNextLineTokens();
				results = loc.parserService.getNextLineTokens();
				expect(results).toBeArray();
				expect(arrayLen(results)).toBe(0);
			});
			
		
		
		});

		// end Unit Test  
			
		// Start CSV Unit Test
		/** 
		* describe() starts a suite group of spec tests.
		* Arguments:
		* @title The title of the suite, Usually how you want to name the desired behavior
		* @body A closure that will resemble the tests to execute.
		* @labels The list or array of labels this suite group belongs to
		* @asyncAll If you want to parallelize the execution of the defined specs in this suite group.
		* @skip A flag that tells TestBox to skip this suite group from testing if true
		*/
		describe( "A CSV Parser spec", function(){
		
			// before each spec in THIS suite group
			beforeEach(function(){
				loc.parserService.setupFileObject(loc.csvFile);
				
			});
			
			// after each spec in THIS suite group
			afterEach(function(){
				
			});
			
			/** 
			* it() describes a spec to test. Usually the title is prefixed with the suite name to create an expression.
			* Arguments:
			* @title The title of the spec
			* @spec A closure that represents the test to execute
			* @labels The list or array of labels this spec belongs to
			* @skip A flag that tells TestBox to skip this spec from testing if true
			*/
			it("can open a text file and read the first line", function(){
 
				expect(loc.parserService).toBeComponent();
				results = loc.parserService.getNextLineTokens();
				expect(results).toBeArray();
				expect(results[1]).NottoBe('csv');
				expect(results[2]).toBe('is');
				expect(results[3]).toBe('a');
				expect(results[4]).toBe('csv');
			
			});
			
			// more than 1 expectation
			it("can open a text file and read the second line", function(){
			
				results = loc.parserService.getNextLineTokens();
				results = loc.parserService.getNextLineTokens();
				expect(results).toBeArray();
				expect(results[1]).toBe('red');
				expect(results[2]).nottoBe('red');
			});

			// negations
			it("can open a text file and read the third line", function(){
				results = loc.parserService.getNextLineTokens();
				results = loc.parserService.getNextLineTokens();
				results = loc.parserService.getNextLineTokens();
				expect(results).toBeArray();
				expect(arrayLen(results)).toBe(0);
			});
			
		
		
		});

		// end Unit Test  	
		// Start PIPE Unit Test
		/** 
		* describe() starts a suite group of spec tests.
		* Arguments:
		* @title The title of the suite, Usually how you want to name the desired behavior
		* @body A closure that will resemble the tests to execute.
		* @labels The list or array of labels this suite group belongs to
		* @asyncAll If you want to parallelize the execution of the defined specs in this suite group.
		* @skip A flag that tells TestBox to skip this suite group from testing if true
		*/
		describe( "A PIPE Parser spec", function(){
		
			// before each spec in THIS suite group
			beforeEach(function(){
				loc.parserService.setupFileObject(loc.pipeFile);
				
			});
			
			// after each spec in THIS suite group
			afterEach(function(){
				
			});
			
			/** 
			* it() describes a spec to test. Usually the title is prefixed with the suite name to create an expression.
			* Arguments:
			* @title The title of the spec
			* @spec A closure that represents the test to execute
			* @labels The list or array of labels this spec belongs to
			* @skip A flag that tells TestBox to skip this spec from testing if true
			*/
			it("can open a text file and read the first line", function(){
 
				expect(loc.parserService).toBeComponent();
				results = loc.parserService.getNextLineTokens();
				expect(results).toBeArray();
				expect(results[1]).NottoBe('pipe');
				expect(results[2]).toBe('is');
				expect(results[3]).toBe('a');
				expect(results[4]).toBe('pipe');
			
			});
			
			// more than 1 expectation
			it("can open a text file and read the second line", function(){
			
				results = loc.parserService.getNextLineTokens();
				results = loc.parserService.getNextLineTokens();
				expect(results).toBeArray();
				expect(results[1]).toBe('red');
				expect(results[2]).nottoBe('red');
			});

			// negations
			it("can open a text file and read the third line", function(){
				results = loc.parserService.getNextLineTokens();
				results = loc.parserService.getNextLineTokens();
				results = loc.parserService.getNextLineTokens();
				expect(results).toBeArray();
				expect(arrayLen(results)).toBe(0);
			});
			
		
		
		});

		// end Unit Test  
		} // end Run()

	// ------------------------ HELPER FUNCTIONS ------------------------ //
    /**
    * I am responsible for determining if OS is windows
    * @access public
    * @returntype boolean
    * @output false
    **/
	    function isWindows(){
	    	return (server.os.name contains "windows")? true: false;
	    }

    /**
    * I am responsible for determing if CFEngine is Railo
    * @access private
    * @returntype boolean
    * @output false
    **/
		function isRailo(){
			return ( structKeyExists( server, "railo" ) );
		}

	/**
    * I am responsible for determing if CFEngine is Lucee
    * @access private
    * @returntype boolean
    * @output false
    **/
		function isLucee(){
			return ( structKeyExists( server, "lucee" ) );
		}

	/**
    * I am responsible for determing if CFEngine is Adobe
    * @access private
    * @returntype boolean
    * @output false
    **/
		function isACF(){
			return ( structKeyExists( server, "coldfusion" ) );
		}
}

