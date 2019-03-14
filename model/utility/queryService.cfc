/**
*
* @file  queryService.cfc
* @author  David Fairfield (david.fairfield@gmail.com)
* 
* */
component {



	/**
	* I am responsible for performing query of queries
	* @access public
	* @returntype query
	* @output false
	**/
		function queryofqueries(required query Data, string SQLString="Select * from data"){

			var thisQuery = new Query();
				thisQuery.setDBType('query');
				thisQuery.setAttributes(data=arguments.data);
				thisQuery.setSQL(arguments.SQLString);

			var results = thisQuery.execute().getResult();
			return results;
		}

	/**
	* I am responsible for converting a struct into a query row
	* @access public
	* @returntype query
	* @output false
	**/
		function structToQueryRow(required query query, required struct data,numeric rownum){
			var item = "" ;
			var returnQ = arguments.query ;
			var keyList = StructKeyList(Arguments.data);

			queryAddRow(arguments.query) ;

			for(item in keyList){
				if(listFindnocase(returnq.ColumnList,item)){
					if(structkeyexists(arguments,'rownum') && isNumeric(arguments.rownum)){
						querySetCell(returnQ,item,arguments.data[item],arguments.rownum) ;
					}else{
						querySetCell(returnQ,item,arguments.data[item]) ;
					}
				}
			}
	    	return returnQ;
		}

	/**
	* I am responsible for converting a query into an array of structures
	* @access public
	* @returntype array
	* @output false
	**/
		function queryToArray(required query data){
	 		var queryArray = [];

	 		for(var row in arguments.data){
	 			arrayAppend(queryArray, row);
	 		}
	 		return queryArray;
	 	}

	/**
	* I am responsible for converting a query row into a struct
	* @access public
	* @returntype struct
	* @output false
	**/
		function queryRowToStruct(required query Query, numeric row=1){
			//a var for looping
			var ii = 1;

			//the cols to loop over
			var cols = listToArray(arguments.query.columnList);

			//the struct to return
			var stReturn = structnew();

			//loop over the cols and build the struct from the query row	
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = arguments.query[cols[ii]][arguments.row];
			}		

			//return the struct
			return stReturn;
		}
}