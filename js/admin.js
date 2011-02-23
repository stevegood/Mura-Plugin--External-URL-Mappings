jQuery(function($){
	
	$('.button').button().click(function(){
		var method = $(this).attr('id');
		var params = {};
		var callback;
		params.method = method;
		
		switch ($(this).attr('id')){
			case "addURLMapping":
				params.contentId = $('input#contentId').val();
				params.externalURL = $('input#externalURL').val();
				callback = function(){
					window.location = window.location;
				};
				break;
			case "removeURLMapping":
				params.contentId = $(this).attr('data-contentId');
				callback = function(){
					window.location = window.location;
				};
				break;
		}
		
		$.getJSON(
			urlMappings.facade,
			params,
			function(result){
				if (result.success){
					if (callback){
						callback();
					}
				} else {
					$('<div>' + result.message + '</div>').dialog({
						title:"Oops!"
					});
				}
			}
		);
	});
	
});