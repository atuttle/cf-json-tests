<h1>Testing ColdFusion's JSON serialization</h1>
<p>Source code for tests: <a href="http://github.com/atuttle/cf-json-tests">http://github.com/atuttle/cf-json-tests</a> (requires MXUnit)</p>

<cfinvoke
	component="mxunit.runner.DirectoryTestSuite"
	method="run"
	directory="#expandPath('tests')#"
	componentPath="scribble.json.tests"
	recurse="true"
	returnvariable="results"
/>
<cfoutput> #results.getResultsOutput('extjs')# </cfoutput>
