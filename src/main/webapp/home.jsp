<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/3cbf1090e8.js" crossorigin="anonymous"></script>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    /* Mobile styles */
    @media only screen and (max-width: 480px) {
      body {
        background-color: white;
        font-family: Arial, sans-serif;
        color: #333;
        padding: 20px;
      }

     header {
  width: 100%;
  height: 80px;
  background-color: #62BAF0;
  color: white;
  text-align: center;
  position: absolute;
  top: 0;
  left:0px;
  font-size: 20px;
  line-height: 60px; /* vertical centering */
}

body {
  padding-top: 90px; /* Prevent content from being hidden under the header */
}
}
</style>
</head>
<body onload="name()">
<header>
<h1 style="font-size: 2rem; color: black; margin-bottom: 20px;"><i class="fa-solid fa-house"></i>  HOMEIN </h1>
</header>
<h5 id="name"></h5>
<script>
function name() 
{
	var xhtml = new XMLHttpRequest();
	var url = "http://localhost:8080/api/loginstatus";
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