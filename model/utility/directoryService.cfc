/**
*
* @file  directoryService.cfc
* @author  David Fairfield (david.fairfield@gmail.com)
* @accessors true
* @extends model.abstract.baseSVC
* */
component {

	/**
	* I am responsible for getting a directory list
	* @access public
	* @returntype any
	* @output false
	*
	**/
		function getDirectory(
			required string path,
			boolean recurse=true,
			string filter="",
			string sort="",
			string type="file",
			array excludedFiles = [],
			array excludedFolders = ["framework","test"],
			array extensions = ["cfm","cfml","cfc","css","js","tab","csv","pipe","fixed"]
		){
			// setup 
			// var thisPath = sanitizePath(arguments.path);
			var thisPath = arguments.path;
			var Results = Querynew(
				'lastmodified,name,path,relativepath,dotpath,size,type,linesofcode,hasdotPath,parentpath,filename,filepath,extension',
				'timestamp,varchar,varchar,varchar,varchar,integer,varchar,integer,bit,varchar,varchar,varchar,varchar'
				);
			var tmpArray =[];
			var tmpList = directoryList(thisPath,Arguments.recurse,'query',arguments.filter,arguments.sort);
			// build Query String 
			switch(arguments.type){
				case "dir":
					var SQLString = "Select * from data where lower(type) = 'dir'";
				break;
				case "file":
					var sqlString = '';
					savecontent variable="sqlString"{
					writeoutput("Select * From data where"& NL);
					var cnt=0;
				
						for(var Filetype in arguments.extensions){
							cnt++;
							if(cnt eq 1){
								writeoutput("lower(type) = '#lcase(arguments.type)#'" & NL);
							}else if(cnt lte arrayLen(arguments.extensions)){
								writeoutput("or lower(type) = '#lcase(arguments.type)#'" & NL);
							}
							writeoutput("and lower(name) like '%.#lcase(filetype)#'"& NL);	
													
							for(var File in arguments.excludedFiles){
								writeoutput("and lower(name) <> '#lcase(file)#'"& NL);
							}
							for(var folder in arguments.excludedFolders){
								writeoutput("and lower(directory) not like '%#lcase(folder)#%'"& NL);
							}
						}
					
					}; // end savecontent
				break;

				default:
				var SQLString = "Select * from data";
				break;
			}

			// customize output
			tmpList = beanfactory.getBean('queryService').queryofqueries(tmpList,SQLString);
			
			for(var item in tmpList){
				var loc = {
					type: item.type,
					lastmodified: item.datelastmodified,
					size: item.size,
					rootpath: thisPath,
					name: item.name,
					path: sanitizePath(item.directory & "/" & item.name),
					dotpath: '',
					hasDotPath: false,
					parentpath: sanitizePath(item.directory & "/"),
					filename: item.name,
					extension: listlast(item.name,'.')
				};
				loc.filePath = loc.path;
				loc.relativepath = beanfactory.getBean('fileService').getRelativePath(loc.path,thisPath);
				loc.linesofcode = beanfactory.getBean('fileService').getlinesOfCode(loc.path);
				if(loc.name contains ".cfc"){
					loc.dotpath = beanfactory.getBean('fileService').getDotPath(loc.relativepath);
				}
				if(len(loc.dotPath)) loc.hasDotPath = true;
				beanfactory.getBean('queryService').structToQueryRow(results, loc);
				
			}

			return results;
		}

	/**
	* I am responsible for sanitizing a path to be usable on both linux and windows
	* @access public
	* @returntype any
	* @output false
	**/
		function sanitizePath(required string path) {
			return replacenocase(arguments.path,'\','/','all');
		}

	/**
	* I am responsible for retrieving directory size
	* @access public
	* @returntype any
	* @output false
	**/
		function getDirectorySize(required string dir){
			Var fso = CreateObject("COM", "Scripting.FileSystemObject");
			var objFolderSize = 0;
			if (directoryExists(arguments.dir)){
			    try{
			        objFolder  = FSO.getFolder(arguments.dir);
			        objFolderSize = LSParseNumber(objFolder.size);
			    }catch(any e){
			    	rethrow; 
			    }
			    // if(objFolderSize)objFolderSize = LSParseNumber(DecimalFormat(Evaluate(objFolderSize / 1000000)));
			}
			return objFolderSize;
		}
}