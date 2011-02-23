<cfcomponent extends="mura.cfobject" output="false">
	
	<cffunction name="init" access="public" returntype="URLService" output="false">
		<cfargument name="settingsService" type="Any" required="true" />
		<cfset variables.settingsService = arguments.settingsService />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="addURLMapping" access="public" returntype="void" output="false">
		<cfargument name="externalURL" type="string" required="true" />
		<cfargument name="contentId" type="string" required="true" />
		
		<cfset var local = {} />
		<cfset local.fileName = 's' & hash(session.siteid) />
		<cfset local.mappings = {} />
		
		<cfif len(application.contentManager.read(contentid=arguments.contentId,siteid=session.siteid).getTitle())>
			<cfif variables.settingsService.valueExists(local.fileName)>
				<cfset local.mappings = variables.settingsService.getValue(local.fileName) />
			</cfif>
			
			<cfif !structKeyExists(local.mappings,arguments.contentId)>
				<cfset local.mappings[arguments.contentId] = arguments.externalURL />
				<cfset variables.settingsService.setValue(local.fileName,local.mappings,true)>
			<cfelse>
				<!--- it looks like we already stored this key, update it instead --->
				<cfset updateURLMapping(arguments.contentId, arguments.externalURL) />
			</cfif>
		</cfif>
	</cffunction>
	
	<cffunction name="removeURLMapping" access="public" returntype="void" output="false">
		<cfargument name="contentId" type="string" required="true" />
		
		<cfset var local = {} />
		<cfset local.fileName = 's' & hash(session.siteid) />
		<cfset local.mappings = {} />
		
		<cfif variables.settingsService.valueExists(local.fileName)>
			<cfset local.mappings = variables.settingsService.getValue(local.fileName) />
		</cfif>
		
		<cfif structKeyExists(local.mappings,arguments.contentId)>
			<cfset structDelete(local.mappings,arguments.contentId) />
		</cfif>
		
		<cfset variables.settingsService.setValue(local.fileName,local.mappings,true) />
	</cffunction>
	
	<cffunction name="updateURLMapping" access="public" returntype="void" output="false">
		<cfargument name="contentId" type="string" required="true" />
		<cfargument name="externalURL" type="string" required="false" default="" />
		<cfargument name="newContentId" type="string" required="false" default="" />
		
		<cfset var local = {} />
		<cfset local.fileName = 's' & hash(session.siteid) />
		<cfset local.mappings = {} />
		
		<cfif variables.settingsService.valueExists(local.fileName)>
			<cfset local.mappings = variables.settingsService.getValue(local.fileName) />
		</cfif>
		
		<cfif len(arguments.externalURL)>
			<cfset local.mappings[arguments.contentId] = arguments.externalURL />
		</cfif>
		
		<cfif len(arguments.newContentId)>
			<cfset addURLMapping(arguments.newContentId,local.mappings[arguments.contentId]) />
			<cfset removeURLMapping(arguments.contentId) />
		<cfelse>
			<cfset variables.settingsService.setValue(local.fileName,local.mappings,true) />
		</cfif>
	</cffunction>
	
	<cffunction name="mappings" access="public" returntype="struct" output="false">
		<cfargument name="siteid" type="string" required="false" default="#session.siteid#" />
		<cfreturn variables.settingsService.getValue('s' & hash(arguments.siteid)) />
	</cffunction>
	
	<cffunction name="getContentId" access="public" returntype="string" output="false">
		<cfargument name="uri" type="string" required="true" />
		<cfargument name="siteid" type="string" required="true" />
		
		<cfset var local = {} />
		<cfset local.contentId = "" />
		<cfset local.mappings = mappings(arguments.siteid) />
		
		<cfloop list="#structKeyList(local.mappings)#" index="local.key">
			<cfset local.uri = local.mappings[local.key] />
			<cfif left(local.uri,1) neq '/'>
				<cfset local.uri = '/' & local.uri />
			</cfif>
			
			<cfif right(local.uri,1) neq '/'>
				<cfset local.uri = local.uri & '/' />
			</cfif>
			
			<cfif local.uri eq arguments.uri>
				<cfset local.contentId = local.key />
				<cfbreak />
			</cfif>
		</cfloop>
		
		<cfreturn local.contentId />
	</cffunction>
	
</cfcomponent>