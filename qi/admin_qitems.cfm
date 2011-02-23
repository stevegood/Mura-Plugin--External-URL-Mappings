<cfoutput>
<script type="text/javascript">
	var urlMappings = urlMappings || {};
	urlMappings.pluginPath = '<cfoutput>#application.configBean.getContext()#/plugins/#request.pluginConfig.getDirectory()#</cfoutput>';
	urlMappings.facade = urlMappings.pluginPath + '/RemoteFacade.cfc';
</script>
<script type="text/javascript" src="#application.configBean.getContext()#/plugins/#request.pluginConfig.getDirectory()#/js/admin.js"></script>
</cfoutput>