<h2>Data files</h2>

<ol>
<cfoutput>
<cfloop index="dataFile" array="#rc.datafiles#">
<li><a href="#buildURL('main.parseFile?dataFile=#dataFile#')#">#dataFile#</a></li>
</cfloop>
</cfoutput>
</ol>