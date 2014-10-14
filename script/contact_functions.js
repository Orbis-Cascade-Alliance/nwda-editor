$(document).ready(function () {
	$('.info-text').each(function () {
		var parsed = replaceURLWithHTMLLinks($(this).text());		
		$(this).html(parsed);
	});
	
	$('.toggle-button').click(function () {
		$(this).next().toggle();
		return false;
	});
	
	/********** URI PARSING **********/
	//construct HTML links from regular expressions
	function replaceURLWithHTMLLinks(text) {
		var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
		return text.replace(exp, constructLink);
	}
	function constructLink(match, p1, offset, string) {
		return "<a href='" + p1 + "'>" + p1 + "</a>";
	}
});