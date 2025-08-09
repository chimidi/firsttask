<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Cart – Unavailable Items</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
  <style>
    body {
      font-family: Arial;
      margin: 60px 15px;
    }
    .row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border: 1px solid #ccc;
      border-radius: 6px;
      margin-bottom: 8px;
      padding: 8px 12px;
    }
    .item-name {
        flex-grow: 1; /* Allow name to take available space */
        font-weight: bold;
    }
    .item-status {
        margin-left: 10px;
        margin-right: 10px;
        color: red; /* Indicate unavailable status */
    }
    .available-btn {
        background-color: #4CAF50; /* Green */
        color: white;
        padding: 5px 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 0.9em;
    }
    .available-btn:hover {
        background-color: #45a049;
    }
  </style>
</head>
<body onload="load()">
<header style="position:fixed;top:0;left:0;right:0;background:#62BAF0;color:#fff;
               display:flex;justify-content:space-between;align-items:center;
               padding:10px 15px;z-index:1000;">
  <h3 onclick="window.location='home.jsp'"><i class="fa-solid fa-house"></i> HOMEIN</h3>
  <span onclick="window.location='home.jsp'"><i class="fa-solid fa-arrow-left"></i> Back</span>
</header>
<h1>Vegetables</h1>
<div id="container" style="margin-top:80px;"></div>
<h1>groceries</h1>
<div id="container1" style="margin-top:80px;"></div>

<script>
function veg() {
	  var xhttp = new XMLHttpRequest();
	  var url = "http://localhost:8080/api/getunv";
	  xhttp.open("GET", url, true);
	  xhttp.setRequestHeader('Content-Type', 'application/json');
	  xhttp.send();

	  var display = document.getElementById("container");

	  xhttp.onreadystatechange = function () {
	    if (this.readyState === 4 && this.status === 200) {
	      var data = JSON.parse(this.responseText);

	      if (!Array.isArray(data) || data === null || data.length === 0) {
	          display.innerHTML = '<div style="text-align: center; margin-top: 50px; color: #666;">No items to display. Add a new item!</div>';
	      } else {
	        var html = "";

	        for (var i = 0; i < data.length; i++) {
	          var item = data[i];
	          var purchaser = item.purchasedBy ? item.purchasedBy.name : "Unknown";
	          var isAvailable = item.available; // Access the correct property name from the JSON
	          var availabilityText = isAvailable ? "AVAILABLE" : "NOT AVAILABLE";
	          var availabilityColor = isAvailable ? "#d4edda" : "#f8d7da";
	          var availabilityTextColor = isAvailable ? "#155724" : "#721c24";

	          html += '<div style="display: flex; border: 1px solid black; border-radius: 8px; padding: 15px; margin-bottom: 20px; box-shadow: 1px 1px 3px rgba(0,0,0,0.15); align-items: center;">';

	          html += '<div style="flex: 1; font-size: 18px; font-weight: bold; text-transform: uppercase;">' + item.name + '</div>';

	          if (isAvailable) {
	            html += '<button onclick="update(\'' + item.id + '\', \'' + item.name + '\')" style="flex: 1; background-color: ' + availabilityColor + '; color: ' + availabilityTextColor + '; padding: 8px 12px; border-radius: 4px; font-weight: bold; border: none; cursor: pointer; font-size: 14px; text-align: center;">' + availabilityText + '</button>';
	          } else {
	            html += '<div style="flex: 1; background-color: ' + availabilityColor + '; color: ' + availabilityTextColor + '; padding: 8px 12px; border-radius: 4px; font-weight: bold; font-size: 14px; text-align: center;">' + availabilityText + '</div>';
	          }

	          html += '<div style="flex: 1; font-size: 14px; color: #555; text-align: right;">Purchased by: ' + purchaser + '</div>';

	          html += '</div>';
	        }

	        display.innerHTML = html;
	      }
	    } else if (this.readyState === 4 && this.status !== 200) {
          console.error("Failed to fetch items. Status:", this.status);
          display.innerHTML = '<div style="text-align: center; margin-top: 50px; color: #dc3545;">Error loading items. Please try again.</div>';
      }
	  };
	}
function gro()
{
	 var xhttp = new XMLHttpRequest();
	  var url = "http://localhost:8080/api/getunvg";
	  xhttp.open("GET", url, true);
	  xhttp.setRequestHeader('Content-Type', 'application/json');
	  xhttp.send();

	  var display = document.getElementById("container1");

	  xhttp.onreadystatechange = function () {
	    if (this.readyState === 4 && this.status === 200) {
	      var data = JSON.parse(this.responseText);

	      if (!Array.isArray(data) || data === null || data.length === 0) {
	          display.innerHTML = '<div style="text-align: center; margin-top: 50px; color: #666;">No items to display. Add a new item!</div>';
	      } else {
	        var html = "";

	        for (var i = 0; i < data.length; i++) {
	          var item = data[i];
	          var purchaser = item.purchasedBy ? item.purchasedBy.name : "Unknown";
	          var isAvailable = item.available; // Access the correct property name from the JSON
	          var availabilityText = isAvailable ? "AVAILABLE" : "NOT AVAILABLE";
	          var availabilityColor = isAvailable ? "#d4edda" : "#f8d7da";
	          var availabilityTextColor = isAvailable ? "#155724" : "#721c24";

	          html += '<div style="display: flex; border: 1px solid black; border-radius: 8px; padding: 15px; margin-bottom: 20px; box-shadow: 1px 1px 3px rgba(0,0,0,0.15); align-items: center;">';

	          html += '<div style="flex: 1; font-size: 18px; font-weight: bold; text-transform: uppercase;">' + item.name + '</div>';

	          if (isAvailable) {
	            html += '<button onclick="update(\'' + item.id + '\', \'' + item.name + '\')" style="flex: 1; background-color: ' + availabilityColor + '; color: ' + availabilityTextColor + '; padding: 8px 12px; border-radius: 4px; font-weight: bold; border: none; cursor: pointer; font-size: 14px; text-align: center;">' + availabilityText + '</button>';
	          } else {
	            html += '<div style="flex: 1; background-color: ' + availabilityColor + '; color: ' + availabilityTextColor + '; padding: 8px 12px; border-radius: 4px; font-weight: bold; font-size: 14px; text-align: center;">' + availabilityText + '</div>';
	          }

	          html += '<div style="flex: 1; font-size: 14px; color: #555; text-align: right;">Purchased by: ' + purchaser + '</div>';

	          html += '</div>';
	        }

	        display.innerHTML = html;
	      }
	    } else if (this.readyState === 4 && this.status !== 200) {
         console.error("Failed to fetch items. Status:", this.status);
         display.innerHTML = '<div style="text-align: center; margin-top: 50px; color: #dc3545;">Error loading items. Please try again.</div>';
     }
	  };
	
	}
	
	function load()
	{
		veg();
		gro();
	}
</script>
</body>
</html>