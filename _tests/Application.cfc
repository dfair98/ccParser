/**
* Clear Captial Parser Unit Test Runner
* @file  Application.cfc
* @author  David Fairfield (david.fairfield@gmail.com)
* 
* */
component{
	this.name = "Parser" & hash( CreateUUID());
	this.Hostname = CGI.SERVER_NAME;
	this.ApplicationRoot = ExpandPath('/');
		


	// any mappings go here, we create one that points to the root called test.
	this.mappings[ "/test" ] = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings[ "/model"] = this.applicationroot & "model/";
	this.mappings[ "/model"] = this.applicationroot & "model/";
	this.mappings[ "/framework"] = this.applicationroot & "framework/";


	
	// request start
	public boolean function onRequestStart( String targetPage ){
	
		
		request.rootPath = this.ApplicationRoot;
		request.beanfactory = new framework.ioc("/model",{ singletonPattern = "(Service|Gateway)$" });
		request.beanfactory.load();


		return true;
	}

}