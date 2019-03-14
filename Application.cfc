/**
* Clear Capital Text Parser
* @file  Application.cfc
* @author  David Fairfield (david.fairfield@gmail.com)
* @extends framework.one
* @output false
* 
* */
component {
// ------------------------ APP SETTINGS ------------------------ //
	this.name = "textParser";
	this.applicationroot = getDirectoryFromPath(getCurrentTemplatePath());
	this.webRootPath = expandpath('/');

// ------------------------ APP MAPPINGS ------------------------ //
	this.mappings["/model"] = this.applicationroot & "model/";
	this.mappings["/framework"] = this.applicationroot & "framework/";

// ------------------------ FW/1 SETTINGS ------------------------ //
	variables.framework = {
		  cacheFileExists = false
		, modestring = "UNDEFINED"
		, mode = "local"
		, reloadApplicationOnEveryRequest =false
		
		, subsystemDelimiter = '_'
		, diEngine = 'di1'
        , diLocations = '/model'
		, diconfig : 
			{
				  singletonPattern : "(Service|Gateway)$"
				, omitDirectoryAliases: true
				, loadListener = factoryConfig
			}
		,environments = {
						dev={ 
							 reloadApplicationOnEveryRequest = true
							,modestring = 'LOCAL DEVELOPMENT'
						}
						,int={ 
							modestring = 'INTEGRATION'
						}
						,qa={ 
							modestring = 'QA'
						}
						,stg={ 
							modestring = 'STAGING'
						}
						,prod={ 
							modestring = 'PRODUCTION'
						}
		}				
		};	

// ------------------------ FW/1 OVERRIDES ------------------------ //

/**
* I am responsible for providing environment-specific initialization
* @access public
* @returntype string
* @output false
**/
	function getEnvironment( string env ){
		var thisHostName = getHostName();
		var mode = 'dev';
    	if ( findNoCase( 'int', thisHostName ) ) mode ='int';
    	if ( findNoCase( 'qa', thisHostName ) ) mode = 'qa';
    	if ( findNoCase( 'tst', thisHostName ) ) mode = 'qa';
    	if ( findNoCase( 'stg', thisHostName ) ) mode = 'stg';
    	if ( findNoCase( 'prd', thisHostName ) ) mode = 'prod';

 		// add additional environments    		
    	return mode;

	}

/**
* I am responsible for providing application-specific initialization. 
* @access public
* @returntype void
* @output false
**/
	function setupApplication(){
		
	}

/**
* I am responsible for providing request-specific initialization. 
* @access public
* @returntype void
* @output false
**/
	function setupRequest(){
		request.context.startTime = getTickCount();
	}


/**
* I am responsible for providing session-specific initialization.
* @access public
* @returntype void
* @output false
**/
	function setupSession(){}

/**
* I am responsible for providing subsystem-specific initialization.
* @access public
* @returntype any
* @output false
**/
	function setupSubsystem( string subsystem ){}


// ------------------------ HELPER FUNCTIONS ------------------------ //

/**
* I am responsible for adding beans that do not match SERVICE or GATEWAY into the beanfactory
* @access private
* @returntype void
* @output false
**/
	function factoryConfig(bf){}

}