/**
* Service abstract layer
* @file  model/abstract/baseSVC.cfc
* @author David Fairfield
* @accessors true
*/
component {
// ------------------------ DEPENDENCY INJECTION ------------------------ //
	property beanFactory;
	property directoryService;

	variables.NL = CreateObject("java", "java.lang.System").getProperty("line.separator");

// ------------------------ CONSTRUCTOR ------------------------ //	

/**
 * I am responsible for instantiating a service object
 * @access public
 * @returntype any
 * @output false
 **/ 
	function INIT( ) {
		
		return this;
	}

/**
* I am responsible for handling missed methods
* @access public
* @returntype any
* @output false
**/
	function ONMISSINGMETHOD(
		required string MissingMethodName, 
		required struct MissingMethodArguments
	){}



}