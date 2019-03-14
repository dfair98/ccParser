/**
*
* @file  fileService.cfc
* @author  David Fairfield (david.fairfield@gmail.com)
* 
* */
component {
	
	/**
	* I am responsible for retrieving file information
	* @access public
	* @returntype any
	* @output false
	**/
		function getfileinfo(required string filename) {
			if(fileExists(Arguments.Filename)){
				var tmpInfo = getfileinfo(arguments.filename);
				var fileInfo={
					readable: (tmpinfo.canRead)? true: false,
					writable: (tmpinfo.canWrite)? true: false,
					isHidden: (tmpinfo.isHidden)? true: false,
					lastModified: tmpinfo.lastModified,
					size: tmpinfo.size,
					filesize: tmpinfo.size,
					fileExt: listLast(tmpinfo.name,'.'),
					exists: true,
					linesofcode: getLinesOfCode(arguments.filename)
				};

				return fileinfo;

			}else{
				var Fileinfo= {
					readable: false,
					writable: false,
					isHidden: false,
					lastModified: '',
					size: 0,
					filesize: 0,
					fileExt: '',
					exists: false,
					linesofcode: 0
				};
			}

			return Fileinfo;
		}


	/**
	* I am responsible for
	* @access public
	* @returntype any
	* @output false
	**/
		function getFile(required string filePath){
			var fileinfo={
				contents: '',
				linesofCode: 0
			};
			var fileContents = "";

			if(FileExists(arguments.filePath)){
				fileinfo.contents = fileRead(FilePath);
				fileinfo.linesofcode =ListLen(fileinfo.contents,chr(10));

			}

			return fileinfo;
		}
	
	/**
	* I am responsible for determining relativepath
	* @access public
	* @returntype any
	* @output false
	**/
		function getRelativePath(required string filepath,required string rootpath){
			var relativePath = '';
			if(fileExists(Arguments.filepath)){
				relativepath = replacenocase(arguments.filepath,arguments.rootpath,'','once');
				return relativepath;
			}
			
			return relativepath;
		}
	
	/**
	* I am responsible for
	* @access public
	* @returntype any
	* @output false
	**/
		function getDotPath(required string relativepath){
			var dotPath = "";

			if(arguments.relativepath contains ".cfc"){		
				dotPath = arguments.relativePath;
				if(left(dotPath,1) is "/") dotPath = mid(relativepath,2,len(relativepath));
				dotPath = replacenocase(dotPath,'/','.','all');
				dotPath = replacenocase(dotPath,'.cfc','','all');
			}
			return dotPath;
		}
	
	
	/**
	* I am responsible for
	* @access public
	* @returntype any
	* @output false
	**/
		function sizeformat(required numeric size){

			if (arguments.size lt 1024) return "#arguments.size# b";
			if (arguments.size lt 1024^2) return "#round(arguments.size / 1024)# kb";
			if (arguments.size lt 1024^3) return "#replacenocase(decimalFormat(arguments.size/1024^2),'.00','','once')# mb";
			return "#replacenocase(decimalFormat(arguments.size/1024^3),'.00','','once')# gb";
		
		}

	/**
	* I am responsible for retriving lines of code from file
	* @access public
	* @returntype any
	* @output false
	**/
		function getLinesOfCode(required string fileName){
			return listLen(fileRead(arguments.filename),chr(10));
		}
	
}