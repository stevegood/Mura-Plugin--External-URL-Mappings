<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

	<cffunction name="onAdminModuleNav" access="public" returntype="String" output="false">
		<cfreturn '<li><a href="#variables.configBean.getContext()#/plugins/#variables.pluginConfig.getDirectory()#/">External Mappings</a></li>' />
	</cffunction>

</cfcomponent>