/**
* Controller abstract layer
* @file  model/abstract/baseCONT.cfc
* @author David Fairfield
* 
*/
component accessors="true"{
// ------------------------ DEPENDENCY INJECTION ------------------------ //
	property beanFactory;


// ------------------------ CONSTRUCTOR ------------------------ //	

	/**
	 * I am responsible for Instantiating a controller instance
	 * @access public
	 * @returntype any
	 * @output false
	 **/ 
		function init( fw ) {
			variables.fw = fw;
			return this;
		}

	/**
	* I am responsible for executing code before controller call
	* @access public
	* @returntype void
	* @output false
	**/
		function before ( rc ){
			rc.today = dateTimeFormat(now(),'full');
			param name="rc.title" default="";
			param name="rc.starttime" default="#getTickCount()#";
			rc.dataFilePath = ExpandPath('/_datafiles/');
		}

	/**
	* I am responsible for executing code after controller call
	* @access public
	* @returntype void
	* @output false
	**/
		function after ( rc ){
			param name="rc.endTime" default="#getTickCount()#";
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