<cfcomponent extends="mura.plugin.plugincfc">
	
	<cffunction name="init" returntype="any" access="public" output="false">
		<cfargument name="pluginConfig" type="any" default="" />

		<cfset variables.pluginConfig = arguments.pluginConfig />
		<cfset variables.key = hash('stevegood') />

		<cfreturn this />
	</cffunction>

	<cffunction name="install" returntype="void" access="public" output="false">
		<cfset cleanUp() />
	</cffunction>

	<cffunction name="update" returntype="void" access="public" output="false">
		<cfset cleanUp() />
	</cffunction>

	<cffunction name="delete" returntype="void" access="public" output="false">
		<cfset cleanUp() />
	</cffunction>
	
	<cffunction name="cleanUp" access="private" returntype="void" output="false">
		<cfif structKeyExists(application,variables.key) && structKeyExists(application[variables.key],'urlService')>
			<cfset structClear(application[key].urlService) />
		</cfif>
	</cffunction>

</cfcomponent>