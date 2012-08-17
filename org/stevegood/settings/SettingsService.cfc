<cfcomponent extends="mura.cfobject" output="false">
	
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="filePath" type="string" required="true" />
		<cfargument name="fileService" type="Any" required="true" />
		<cfset variables.filePath = arguments.filePath />
		<cfset variables.fileService = arguments.fileService />
		<cfset variables.fileService.setupDirectory(variables.filePath,true) />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getValue" access="public" returntype="any" output="false">
		<cfargument name="key" type="string" required="true" />
		
		<cfset var local = {} />
		
		<cfif !super.valueExists(arguments.key)>
			<cfset local.fromFile = variables.fileService.readFromFile(arguments.key & '.cfm',variables.filePath) />
			<cfif len(structKeyList(local.fromFile))>
				<cfset super.setValue(arguments.key,local.fromFile) />
			<cfelse>
				<cfset setValue(arguments.key,structNew()) />
			</cfif>
		</cfif>
		
		<cfreturn super.getValue(arguments.key) />
	</cffunction>
	
	<cffunction name="setValue" access="public" returntype="void" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfargument name="value" type="any" required="true" />
		<cfargument name="saveToFile" type="boolean" required="false" default="false" />
		
		<cfset super.setValue(arguments.key,arguments.value) />
		
		<cfif arguments.saveToFile>
			<cfset variables.fileService.writeToFile(arguments.key & '.cfm',getValue('filePath'),serializejson(arguments.value)) />
		</cfif>
	</cffunction>
	
	<cffunction name="removeValue" access="public" returntype="void" output="false">
		<cfargument name="key" type="string" required="true" />
		<cfargument name="removeFile" type="boolean" required="false" default="false" />
		
		<cfset super.removeValue(arguments.key) />
		
		<cfif arguments.removeFile>
			<cfset variables.fileService.deleteFile(arguments.key & '.cfm',getValue('filePath')) />
		</cfif>
	</cffunction>
	
</cfcomponent>