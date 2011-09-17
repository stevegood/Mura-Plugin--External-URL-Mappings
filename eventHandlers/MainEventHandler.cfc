<cfcomponent extends="mura.plugin.pluginGenericEventHandler">
	
	<cffunction name="onApplicationLoad" access="public" returntype="void" output="false">
		<cfset var local = {} />
		<cfset var key = hash('stevegood') />
		<cfset local[key] = {} />
		
		<cfif !structKeyExists(application,key)>
			<cfset application[key] = {} />
		</cfif>
		
		<cfif structKeyExists(application[key],'urlService')>
			<cfset structDelete(application[key],'urlService') />
		</cfif>
		
		<cfset local[key].fileService = createObject("component","extURLMappings.org.stevegood.file.FileService").init() />
		
		<cfset local.filePath = expandPath(variables.configBean.getContext() & '/plugins/' & variables.pluginConfig.getDirectory() & '/configFiles') />
		<cfset local[key].settingsService = createObject("component","extURLMappings.org.stevegood.settings.SettingsService").init(local.filePath,local[key].fileService) />
		
		<cfset application[key].urlService = createObject("component","extURLMappings.org.stevegood.URL.URLService").init(local[key].settingsService) />
	</cffunction>
	
	<cffunction name="onRequestStart">
		<cfset request.extURLKey = hash('stevegood') />
	</cffunction>
	
	<cffunction name="onGlobalRequestStart">
		<cfset onRequeststart() />
	</cffunction>
	
	<cffunction name="handle">
		<cfargument name="event" />
		<cfset var local = {} />
		<cfset local.page = "/" & arguments.event.getValue('currentFileName') />
		
		<cfif right(local.page,1) neq '/'>
			<cfset local.page = local.page & '/' />
		</cfif>
		
		<cfset local.contentid = application[request.extURLKey].urlService.getContentId(local.page,arguments.event.getValue('siteid')) />
		
		<cfif len(local.contentid)>
			<!--- Use a 301 instead to let search engines know this move is not temporary --->
			<cfheader statuscode="301" statustext="Document Moved"> 
			<cfheader name="Location" value="#application.contentManager.read(contentid=local.contentid,siteid=arguments.event.getValue('siteid')).getURL()#">
		</cfif>
	</cffunction>
	
</cfcomponent>