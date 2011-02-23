<cfcomponent extends="mura.cfobject" output="false">
	
	<cffunction name="init" access="public" returntype="FileService" output="false">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setupDirectory" access="public" returntype="void" output="false">
		<cfargument name="filePath" type="string" required="true" />
		<cfargument name="protectDirectory" type="boolean" required="false" default="true" />
		
		<cfset var local = {} />
		
		<cfif !directoryexists(arguments.filePath)>
			<cfdirectory action="create" directory="#arguments.filepath#" />
		</cfif>
		
		<cfif arguments.protectDirectory>
			<cfset local.abortTag = "<cfabort />" />
			<cfset writeToFile("Application.cfm",arguments.filePath,local.abortTag) />
		</cfif>
	</cffunction>
	
	<cffunction name="writeToFile" access="public" returntype="void" output="false">
		<cfargument name="fileName" type="string" required="true" />
		<cfargument name="filePath" type="string" required="true" />
		<cfargument name="fileContent" type="string" required="true" />
		
		<cfif !directoryexists(arguments.filePath)>
			<cfdirectory action="create" directory="#arguments.filepath#" />
		</cfif>
		
		<cffile action="write" file="#arguments.filePath#/#arguments.fileName#" output="#arguments.fileContent#" />
	</cffunction>
	
	<cffunction name="readFromFile" access="public" returntype="struct" output="false">
		<cfargument name="fileName" type="string" required="true" />
		<cfargument name="filePath" type="string" required="true" />
		
		<cfset var local = {} />
		<cfset local.s = {} />
		
		<cfif fileExists(arguments.filePath & '/' & arguments.fileName)>
			<cfset local.fc = "" />
			<cffile action="read" file="#arguments.filePath#/#arguments.fileName#" variable="local.fileRead" />
			<cftry>
				<cfset local.fc = deserializejson(local.fileRead) />
				<cfcatch><!--- Don't do anything ---></cfcatch>
			</cftry>
			<cfif isValid("Struct",local.fc)>
				<cfset local.s = local.fc />
			</cfif>
		</cfif>
		
		<cfreturn local.s />
	</cffunction>
	
	<cffunction name="deleteFile" access="public" returntype="void" output="false">
		<cfargument name="fileName" type="string" required="true" />
		<cfargument name="filePath" type="string" required="true" />
		
		<cfif fileExists(arguments.filePath & '/' & arguments.fileName)>
			<cffile action="delete" file="#arguments.filePath#/#arguments.fileName#" />
		</cfif>
	</cffunction>
	
</cfcomponent>