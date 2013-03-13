<cfsilent>
<cfscript>

	testData = {

		query = QueryNew("col1,col2,col3","Integer,VarChar,Bit")

		,struct = { w = 1.0, x = "123", y = 123, z = "1.23", a = "7D7", b = "7E7", c = "7D6", d = "7E6" }

		,octal = -077

		,doublezero = '00'

		,hexcolor = '350E25'
		,hexcolor2 = '24093D'

	};

	QueryAddRow(testData.query);
	QuerySetCell(testData.query,"col1",3);
	QuerySetCell(testData.query,"col2","3");
	QuerySetCell(testData.query,"col3",1);

</cfscript>
</cfsilent>
<html>
	<head>
		<title>Testing ACF serializeJSON</title>
		<link rel="stylesheet" href="assets/jasmine.css" />
		<script type="text/javascript" src="assets/jasmine.js"></script>
		<script type="text/javascript" src="assets/jasmine-html.js"></script>
	</head>
	<body>
		<h1>Testing ColdFusion's JSON serialization</h1>
		<p>Source code for tests: <a href="http://github.com/atuttle/cf-json-tests">http://github.com/atuttle/cf-json-tests</a></p>

		<script type="text/javascript">
			<cfoutput>
				var clientTestData = #serializeJson(testData)#;
			</cfoutput>

			describe("ACF serializeJSON", function(){

				//---- QUERY

				it("should serialize numeric query column data to numerics", function(){
					expect(clientTestData.QUERY.DATA[0][0]).toBe(3);
				});

				it("should serialize numeric string query column data to numeric strings", function(){
					expect(clientTestData.QUERY.DATA[0][1]).toBe('3');
				});

				it("should serialize numeric string query column data to numeric strings", function(){
					expect(clientTestData.QUERY.DATA[0][2]).toBe(true);
				});

				//---- STRUCTURE

				it("should serialize structure keys of floating point numeric data as floating point", function(){
					expect(clientTestData.STRUCT.W).toBe(1.0);
				});

				it("should serialize structure keys of numeric strings as numeric strings", function(){
					expect(clientTestData.STRUCT.X).toBe('123');
				});

				it("should serialize structure keys of integers as integers", function(){
					expect(clientTestData.STRUCT.Y).toBe(123);
				});

				it("should serialize structure keys of floating point numeric strings as floating point numeric strings", function(){
					expect(clientTestData.STRUCT.Z).toBe('1.23');
				});

				//---- SCIENTIFIC NOTATION

				it("should serialize structure keys of string data as strings", function(){
					expect(clientTestData.STRUCT.A).toBe('7D7');
				});

				it("should serialize structure keys of string data as strings, not numeric data in scientific notation", function(){
					expect(clientTestData.STRUCT.B).toBe('7E7');
				});

				it("should serialize structure keys of string data as strings", function(){
					expect(clientTestData.STRUCT.C).toBe('7D6');
				});

				it("should serialize structure keys of string data as strings, not numeric data in scientific notation", function(){
					expect(clientTestData.STRUCT.D).toBe('7E6');
				});

				it("should leave scientific-looking numeric strings as strings", function(){
					expect(clientTestData.HEXCOLOR).toBe('350E25'); //CSS color hex
				});

				it("should leave scientific-looking numeric strings as strings", function(){
					expect(clientTestData.HEXCOLOR2).toBe('24093D'); //CSS color hex
				});

				//---- OCTAL NOTATION

				it("should serialize structure keys of floating point numeric strings as floating point numeric strings", function(){
					expect(clientTestData.OCTAL).toBe(-63);
				});

				//---- OTHER NUMERIC STRING ODDITIES

				it("should serialize '00' as the string '00'", function(){
					expect(clientTestData.DOUBLEZERO).toBe('00');
				});

			});

		</script>

		<!--- initiate jasmine tests --->
		<script>
			(function() {
				var jasmineEnv = jasmine.getEnv();
				jasmineEnv.updateInterval = 1000;

				var htmlReporter = new jasmine.HtmlReporter();

				jasmineEnv.addReporter(htmlReporter);

				jasmineEnv.specFilter = function(spec) {
					return htmlReporter.specFilter(spec);
				};

				var currentWindowOnload = window.onload;

				window.onload = function() {
					if (currentWindowOnload) {
						currentWindowOnload();
					}
					execJasmine();
				};

				function execJasmine() {
					jasmineEnv.execute();
				}

			})();
    </script>
	</body>
</html>
