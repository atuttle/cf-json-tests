<cfcomponent extends="mxunit.framework.TestCase">

	<cfscript>

		//testcase provided by Nathan Mische
		function numeric_strings_in_queries(){
			var q = QueryNew("col1,col2,col3","Integer,VarChar,Bit");
			QueryAddRow(q);
			QuerySetCell(q,"col1",3);
			QuerySetCell(q,"col2","3");
			QuerySetCell(q,"col3",1);
			var res = SerializeJSON(q); //{"COLUMNS":["COL1","COL2","COL3"],"DATA":[[3,3,true]]}

			debug(res);
			assertFalse(isNumeric( deserializeJson(res).data[1][2] ), "Expected string, got numeric");
		}

		//testcase provided by Nathan Mische
		function numeric_strings_in_structs(){
			var s = { x = "123", y = 123, z = "1.23" };
			var res = serializeJSON(s);

			debug(res);
			assertFalse(isNumeric( deserializeJSON(res).x ), "Expected string, got numeric" );
		}

		//testcase provided by Adam Tuttle
		function octal_notation(){
			var s = { 'foo': -077 };
			var res = serializeJSON(s);

			debug(res);
			assertEquals(-63, deserializeJSON(res).foo, "octal notation doesn't work" );
		}

	</cfscript>

</cfcomponent>
