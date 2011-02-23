<!--- 
	Plugin: External URL Mappings
 --->

<cfinclude template="plugin/config.cfm" />

<cfsilent>
	<cfset $ = application.serviceFactory.getBean('MuraScope') />
	<cfset urlService = application[request.extURLKey].urlService />
	<cfset mappings = urlService.mappings() />
	<cfset application.contentRenderer.loadJSLib() /><!--- make sure we always have jQuery --->
	<cfset request.pluginConfig.addToHTMLHeadQueue('qi/admin_qitems.cfm') />
	<cfset externalURLTooltip = "The URL that does not match the Mura pathing." />
	<cfset contentIdTooltip = "The Content ID of the page the External URL should resolve to. You can find the Content ID on the Advanced tab of any content item." />
</cfsilent>

<cfsavecontent variable="variables.body">
	<cfoutput>
	<h2>#request.pluginConfig.getName()#</h2>
	<h3 class="alt">
		Please note that this really only works when the external URL is a valid SES URL. That is, the URL does not contain the name of the script (*.[php|cfm|asp|jsp]).
	</h3>
	
	<div>
		<dl class="oneColumn">
			<dt class="first">
				<a href="##" class="tooltip">External URL:<span>#externalURLTooltip#</span></a>
			</dt>
			<dd>
				<input id="externalURL" class="textLong" />
			</dd>
			<dt>
				<a href="##" class="tooltip">Mura Content ID:<span>#contentIdTooltip#</span></a>
			</dt>
			<dd>
				<input id="contentId" class="textLong" />
			</dd>
		</dl>
		<div class="button" id="addURLMapping">Add Mapping</div>
	</div>
	<p>&nbsp;</p>
	<div>
		<h3 class="alt">Mapped URLs</h3>
		
		<table class="stripe">
			<tbody>
				<tr class="">
					<th class="varWidth">External URL</th>
					<th>Content</th>
					<th class="administration">&nbsp;</th>
				</tr>
				
				<cfloop list="#structKeyList(mappings)#" index="key">
					<cfset content = application.contentManager.read(contentid=key,siteid=session.siteid) />
					<tr class="alt">
						<td class="varWidth">#mappings[key]#</td>
						<td><a href="##" class="tooltip">#content.getTitle()# <span>#key#<br/>#content.getURL()#</span></a></td>
						<td class="administration">
							<ul class="four">
								<div class="button" id="removeURLMapping" data-contentId="#key#">Remove</div>
							</ul>
						</td>
					</tr>
				</cfloop>
					
			</tbody>
		</table>
		
		
	</div>
	</cfoutput>
</cfsavecontent>

<cfoutput>#application.pluginManager.renderAdminTemplate(body=variables.body,pageTitle=request.pluginConfig.getName())#</cfoutput>