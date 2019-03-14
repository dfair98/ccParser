<cfoutput>
<h2>Parsed #rc.datafile#:</h2>
<ol>
    <cfloop from="1" to="#Arraylen(rc.results)#" index="lineNum">
    <cfset fileContent = rc.results[linenum]>
    <li>
      
        <ol>
            <Cfloop index ="fileContent" array="#fileContent#">
                <li>#FileContent#</li>
            </cfloop>

</ol>
        </li>
    </cfloop>
</ol>
</cfoutput>