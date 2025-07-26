<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="name()">
<h1 style="text-align:center;font-size:300px;">THIS SITE IS UNDER MAINTAINCE</h1>
<h5 id="name"></h5>
<script>
function name() 
{
	var xhtml = new XMLHttpRequest();
	var url = "https://firsttask-production.up.railway.app/api/loginstatus";
	xhtml.open("GET", url, true);
	xhtml.setRequestHeader('Content-Type','application/json');
	xhtml.send();
	xhtml.onreadystatechange = function()
	{
		if(this.readyState == 4 && this.status == 200)
		{
			     if(this.responseText!="index.jsp")
		         document.getElementById("name").innerHTML ="hi " + this.responseText;
			     else
			    	window.location.replace(this.responseText);
				
		}
	};
}
</script>
</body>
</html>