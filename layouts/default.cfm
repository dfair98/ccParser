<html>
	<head>
		<!--- title set by a view - there is no default --->
		<title>Clear Captial Parser </title>
	</head>
	<body>
		<h1>Clear Captial Parser </h1>
		<cfoutput>#body#</cfoutput>	<!--- body is result of views --->
		<p style="font-size: small;">
			Powered by FW/1 version <cfoutput>#variables.framework.version#</cfoutput>.<br />
			This request took <cfoutput>#getTickCount() - rc.startTime#</cfoutput>ms.
		</p>
	</body>
</html>