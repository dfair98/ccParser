/**
*
* @file  utilityService.cfc
* @author  David Fairfield (david.fairfield@gmail.com)
* 
* */
component extends="tagbased"{
	/**
	* @displayname CapFirst()
	* @hint I capitalize the character or every word in passed in string
	*/

	/**
	* I am responsible for capitalize the character or every word in passed in string
	* @access public
	* @returntype string
	* @output false
	**/
		function CapFirst(required string inputString){
			return rereplace(lcase(arguments.inputString), "(\b\w)", "\u\1", "all");
		}	

     /**
     * I am responsible for returning the local hostname of the server
     * @access public
     * @returntype string
     * @output false
     **/
	    function getHostname() {
	        return createObject( 'java', 'java.net.InetAddress' ).getLocalHost().getHostName();
	    }


	/**
	* I am responsible for determinging if a string contains a substring
	* @access public
	* @returntype boolean
	* @output false
	**/
		function containsString(required string substr, required string str){
		    var results = false;

		    if(arguments.str contains arguments.substr)results = true;

		    return results;
		}


	/**
	* I am responsible for returning the time interval from now();
	* @access public
	* @returntype string
	* @output false
	**/
		function getTimeInterval(date, datemask="dddd dd mmmm yyyy"){
			var timeinseconds = 0;
			var result = "";
			var interval = "";
			if(IsDate(arguments.date)){
				timeinseconds = DateDiff('s', arguments.date, Now());
				// less than a minute
				if(timeinseconds < 60){
					result = " less than a minute ago";
				}
				// less than an hour
				else if (timeinseconds < 3600){
					interval = Int(timeinseconds / 60);
					// more than 1 minute
					if (interval > 1) result = interval & " minutes ago";
					else result = interval & " minute ago";
				}
				// less than 24 hours
				else if (timeinseconds < (86400) && Hour(Now()) >= Hour(arguments.date)){
					interval = Int(timeinseconds / 3600);
					// more than 1 hour
					if (interval > 1) result = interval & " hours ago";
					else result = interval & " hour ago";
				}
				// less than 48 hours
				else if (timeinseconds < 172800){
					result = "yesterday" & " at " & TimeFormat(arguments.date, "HH:MM");
				}
				// return the date
				else{
					result = DateFormat(arguments.date, arguments.datemask) & " at " & TimeFormat(arguments.date, "HH:MM");
				}
			}
			return result;
		}

	/**
	* I am responsible for unindenting a string
	* @access public
	* @returntype string
	* @output false
	**/
		function unIndent(str) {
			var lines = str.split("\n");
			var i = 0;
			var minSpaceDist = 9999;
			var newStr = "";

			for(i=1; i lte arrayLen(lines); i=i+1) {
				if (len(trim(lines[i]))) {
					minSpaceDist = max( min(minSpaceDist, reFind("[\S]",lines[i])-1), 0);
				}
			}

			for(i=1; i lte arrayLen(lines); i=i+1) {
				if (len(lines[i])) {
					newStr = newStr & removeChars(lines[i], 1, minSpaceDist);
				}
				newStr = newStr & chr(10);
			}
			return newStr;
		}

	/**
    *  @displayname toXML
    *  @hint  Convert Structures/Arrays (including embedded) to XML.
    *  @param input      Data to convert into XML. (Required)
    *  @param element      Used to name the root element. (Required)
    *  @return Returns a string. 
    *  @author Phil Arnold (philip.r.j.arnold@googlemail.com) 
    *  @version 0, September 9, 2009 
    */
		public string function toXML (required any input, required string element){
			   var i = 0;
	        var s = '';
	        var s1 = "";
	        s1 = arguments.element;
	        if (right(s1, 1) IS "s") {
	            s1 = left(s1, len(s1)-1);
	        }
	        
	        s = s & "<#lcase(arguments.element)#>";
	        if (isArray(arguments.input)) {
	            for (i = 1; i lte arrayLen(arguments.input); i = i + 1) {
	                if (isSimpleValue(arguments.input[i])) {
	                    s = s & "<#lcase(s1)#>" & arguments.input[i] & "</#lcase(s1)#>";
	                } else {
	                    s = s & toXML(arguments.input[i], s1);
	                }
	            }
	        } else if (isStruct(arguments.input)) {
	            for (i in arguments.input) {
	                if (isSimpleValue(arguments.input[i])) {
	                    s = s & "<#lcase(i)#>" & arguments.input[i] & "</#lcase(i)#>";
	                } else {
	                    s = s & toXML(arguments.input[i], i);
	                }
	            }
	        } else {
	            s = s & XMLformat(arguments.input);
	        }
	        s = s & "</#lcase(arguments.element)#>";

	        return s;

		}

	/**
	* I am responsible for returning a percentage
	* @access public
	* @returntype any
	* @output false
	**/
		function percentage(Value,Maximum) {
			try{
				return decimalformat(((Value/Maximum)*100));
			}catch(any e){
				return 0;
			}
		}

	/**
	* I make a http call and return contents
	*/

	/**
	* I am responsible for performing an http request and returning the content
	* @access public
	* @returntype string
	* @output false
	**/
		function getHTTPRequest(
			required string urlString, 
			array params=[], 
			string method="get"){

			try{
				/* create new http service */ 
			    var httpService = new http(); 
			    /* set attributes using implicit setters */ 
			    httpService.setMethod(arguments.method); 
			    httpService.setCharset("utf-8"); 
			    httpService.setUrl(arguments.urlString); 

			    /* add httpparams using addParam() */ 
			    for(var key in arguments.params){
			    	 httpService.addParam(type=key.type,name=key.name,value=key.value); 
			    }
			 
			    /* make the http call to the URL using send() */ 
			    result = httpService.send().getPrefix(); 

			}catch(any e){
				return 'HTTP Error 404';
			}   

		    return result.fileContent;

		}

		/**
		* I am responsible for checking to see if string is upper case
		* @access public
		* @returntype boolean
		* @output false
		**/
		function isUpperCase(required string str){
			var results = false;
			var thisLen = len(arguments.str);
			var aLen = 0;
			var test = reMatch('[A-Z]+', arguments.str);
			if(isArray(test) && ArrayLen(test)){
				 aLen = len(test[1]);
				if(aLen eq ThisLen){
					results = true;
				}

			}
			return results;
		}



	/**
	* I am responsible for returning formatted percentage
	* @access public
	* @returntype string
	* @output false
	**/
		function percentageFormat(required numeric percentage){
			var thisPercentage = numberformat(arguments.percentage,'___.00');

			thisPercentage = replacenocase(thisPercentage,'.00','','all');
			thisPercentage &='%';

			return trim(thisPercentage);
		}

	/**
	* I am responsible for returning a snippet of a string
	* @access public
	* @returntype string
	* @output false
	**/
		function snippet(required string str, numeric characterCount = 100) {
			local.result = Trim(reReplace(arguments.str, "<[^>]{1,}>", " ", "all"));
			if (Len(local.result) > arguments.characterCount + 10) {
				return Trim(Left(local.result, arguments.characterCount));
			} else {
				return local.result;
			}
		}

	/**
	* I am responsible for converting an ORM object
	* @access public
	* @returntype any
	* @output false
	**/
		function deORM( obj ){ return deserializeJson( serializeJson( obj ) ); }
}