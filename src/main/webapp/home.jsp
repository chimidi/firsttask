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
      height: 60px;
      background-color: #62BAF0;
      color: white;
      position: fixed;
      top: 0;
      left: 0;
      z-index: 999;
    }

    .header-content {
      display: flex;
      justify-content: space-between;
      align-items: center;
      height: 100%;
      padding: 0 15px;
    }

    .header-content h1 {
      font-size: 18px;
      color: black;
    }
    .welcome-container {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 6px;
  margin-top: 20px;
  font-size: 18px;
}
  .all-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 130px;
  gap: 40px;
}

.row {
  display: flex;
  justify-content: center;
  gap: 40px;
  flex-wrap: wrap;
}

.item-box {
  width: 140px;
  text-align: center;
  padding: 15px;
  background-color: white;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  border: none; /* Remove default button border */
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.item-box:hover {
  transform: scale(1.03);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
}

.cart-wrapper {
  position: relative;
  width: 70px;
  height: 70px;
  background-color: #007BFF; /* blue background */
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 80px auto; /* centers horizontally */
  animation: bounce 1.2s infinite;
}

.cart-wrapper i {
  color: white;
  font-size: 36px;
  z-index: 1;
}

/* Count badge on top-right */
.cart-count {
  position: absolute;
  top: -5px;
  right: -5px;
  background-color: red;
  color: white;
  font-size: 14px;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  font-weight: bold;
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
  z-index: 2;
  animation: bounce 1.2s infinite;
}

@keyframes bounce {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-3px);
  }
}

.note {
  text-align: center;
  margin-top: -40px;
  font-size: 16px;
}

.note button {
  background-color: green;
  color: white;
  border: none;
  padding: 8px 16px;
  font-size: 14px;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.note button:hover {
  background-color: darkgreen;
}



body {
  padding-top: 60px; /* Prevent content from being hidden under the header */
}
}
</style>
</head>
<body onload="name()">
<header>

<div class="header-content">
    <h1><i class="fa-solid fa-house"></i> HOMEIN</h1>
    <i style="font-size:10px;" class="fa-solid fa-right-from-bracket"> Logout</i>
  </div>
</header>

<div class="welcome-container">
  <h5>Welcome</h5>
  <h5 id="name"></h5>
</div>
<br>
<div>
 <marquee>There is no text right not. The text will automatically delete after 24hrs </marquee>
</div>
<div class="all-container">
  <div class="row">
   <button class="item-box" id="vegetables" onclick="reveg()">
  <img src="./images/vegetables.png" alt="Vegetable Icon" width="100" height="100">
  <h3>Vegetables</h3>
</button>


    <div class="item-box" id="groceries">
      <img src="./images/basket.png" alt="Groceries Icon" width="100" height="100">
      <h3>Groceries</h3>
    </div>
  </div>

  <div class="item-box" id="accessories">
    <img src="./images/bookshelf.png" alt="Accessories Icon" width="100" height="100">
    <h3>Accessories</h3>
  </div>
</div>

<div class="cart-wrapper">
  <i class="fa-solid fa-cart-shopping"></i>
  <span class="cart-count">1</span>
</div>

<div class="note">
<h5>Leave a Note <br><button>Note</button></h5>
</div>

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
		         document.getElementById("name").innerHTML =this.responseText;
			     else
			    	window.location.replace(this.responseText);
				
		}
	};
	
}

function reveg() {
	window.location.replace("vegetable.jsp");
}
</script>
</body>
</html>