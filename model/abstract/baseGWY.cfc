/**
* Gateway abstract layer
* @file  model/abstract/baseGWY.cfc
* @author David Fairfield
* 
*/
component {
// ------------------------ DEPENDENCY INJECTION ------------------------ //
	property beanFactory;

// ------------------------ CONSTRUCTOR ------------------------ //
/**
* I am responsible for instantiating gateway object
* @access public
* @returntype any
* @output false
**/
	function init() {
		return this;
	}

/**
* I am responsible for handling missed methods
* @access public
* @returntype any
* @output false
**/
	function OnMissingMethod(
		required string MissingMethodName, 
		required struct MissingMethodArguments
	){}
}

