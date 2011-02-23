<cfcomponent output="false">
	
	<!--- global properties --->
	<cfset variables.instance.key = hash('stevegood') />
	
	<cffunction name="addURLMapping" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="externalURL" type="string" required="true" />
		<cfargument name="contentId" type="string" required="true" />
		
		<cfset var local = {} />
		<cfset local.response = {} />
		<cfset local.response['success'] = true />
		<cfset local.response['echo'] = arguments />
		
		<cftry>
			<cfset application[variables.instance.key].urlService.addURLMapping(argumentCollection=arguments) />
			<cfcatch>
				<cfset local.response['success'] = false />
				<cfset local.response['message'] = "There was an error processing your request. Please check your settings and try again." />
				<cfset local.response['debug'] = cfcatch />
			</cfcatch>
		</cftry>
		
		<cfreturn local.response />
	</cffunction>
	
	<cffunction name="removeURLMapping" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="contentId" type="string" required="true" />
		
		<cfset var local = {} />
		<cfset local.response = {} />
		<cfset local.response['success'] = true />
		<cfset local.response['echo'] = arguments />
		
		<cftry>
			<cfset application[variables.instance.key].urlService.removeURLMapping(argumentCollection=arguments) />
			<cfcatch>
				<cfset local.response['success'] = false />
				<cfset local.response['message'] = "There was an error processing your request. Please check your settings and try again." />
				<cfset local.response['debug'] = cfcatch />
			</cfcatch>
		</cftry>
		
		<cfreturn local.response />
	</cffunction>
	
	<cffunction name="updateURLMapping" access="remote" returntype="struct" returnformat="json" output="false">
		<cfargument name="contentId" type="string" required="true" />
		<cfargument name="externalURL" type="string" required="false" default="" />
		<cfargument name="newContentId" type="string" required="false" default="" />
		
		<cfset var local = {} />
		<cfset local.response = {} />
		<cfset local.response['success'] = true />
		<cfset local.response['echo'] = arguments />
		
		<cftry>
			<cfset application[variables.instance.key].urlService.updateURLMapping(argumentCollection=arguments) />
			<cfcatch>
				<cfset local.response['success'] = false />
				<cfset local.response['message'] = "There was an error processing your request. Please check your settings and try again." />
				<cfset local.response['debug'] = cfcatch />
			</cfcatch>
		</cftry>
		
		<cfreturn local.response />
	</cffunction>
	
</cfcomponent>