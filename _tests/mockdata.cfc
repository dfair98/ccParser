component{

	variables.datasource = "codeinspectortest";


	function PreTestSetup(){
		truncateTables();
		populateTablesWithMockData();

	}

	function truncateTables(){
		var tblList = getTables();

		for(tbl in tblList){
			tmp = queryExecute('SET sql_safe_updates=0;');
			tmp = queryExecute("TRUNCATE TABLE #tbl.table_name#;");
		}
		

	}

	function populateTablesWithMockData(){
		var tblList = getTables();
		for(var tbl in tblList){
			var cols = getColumns(tbl.table_name);
			var colList = valueList(cols.otherfields.column_name,',');
			for(var i=1; i lte 100; i++){
			var SQLString = "Insert into #tbl.table_name# (#cols.pkfield#,#colList#)values('#i#',";
				var cnt = 0;
				for(var col in cols.otherfields){
					cnt++;
					SQLString = SQLString & generateData(col,i);
					if(cnt lte cols.otherFields.recordcount){
						SQLString = SQLString & ",";
					}
				}
			SQLString = SQLString & ")";
			SQLString = replacenocase(SQLString,',)',')','once');
			queryExecute(SQLString);

			}
			
		}

	}

	function getTables(){
		cfdbinfo(datasource="#variables.datasource#", name="tables", type="tables");

		return tables;
	}

	function getColumns(required string tablename){

			cfdbinfo(datasource="#variables.datasource#", name="cols", type="COLUMNS", table=arguments.tablename);
		var loc = {
			PkField = queryofQueries(cols,"Select column_name, type_name, Ordinal_position from data where is_primarykey = 'YES'").column_name,
			OtherFields = queryofQueries(cols,"Select column_name, type_name, Ordinal_position from data where is_primarykey = 'NO' order by Ordinal_position")
		};
		return loc;
	}

		function queryofqueries(required query Data, string SQLString="Select * from data"){

			var thisQuery = new Query();
				thisQuery.setDBType('query');
				thisQuery.setAttributes(data=arguments.data);
				thisQuery.setSQL(arguments.SQLString);

			var results = thisQuery.execute().getResult();
			return results;
		}
function generateData(required struct field, required numeric i){

	switch(arguments.field.type_name){

		case "timestamp": case "datetime": case "date":
			return "#createODBCDate(now())#";
		break;
		case "integer": case "int": case "tinyint": case "bigint":
			return i;
		break;
		case "boolean": case "bit":
			return true;
		break;
		default:
			return "'Random Text #i#'";
		break;
	}
}

}