<h1>Testing ColdFusion's JSON serialization</h1>
<p>Source code for tests: <a href="http://github.com/atuttle/cf-json-tests">http://github.com/atuttle/cf-json-tests</a> (requires MXUnit)</p>

<cfinvoke
	component="mxunit.runner.DirectoryTestSuite"
	method="run"
	directory="#expandPath('tests')#"
	componentPath="#figureOutDotPath( expandPath('tests') )#"
	recurse="true"
	returnvariable="results"
/>
<cfoutput> #results.getResultsOutput('extjs')# </cfoutput>

<cffunction name="figureOutDotPath" access="private" output="false" returntype="string">
	<cfset local.indexcfmpath = cgi.script_name />
	<cfset local.testsPath = listDeleteAt(local.indexcfmpath, listLen(local.indexcfmpath, "/"), "/") & "/tests" />
	<cfif GetContextRoot() NEQ "">
		<cfset local.testsPath = ReReplace(local.testsPath,"^#GetContextRoot()#","")>
	</cfif>
	<cfif left(local.testsPath, 1) eq '/'>
		<cfset local.testsPath = right(local.testsPath, len(local.testsPath)-1) />
	</cfif>
	<cfset local.testsPath = replace(local.testsPath, "/", ".", "all") />
	<cfreturn local.testsPath />
</cffunction>
