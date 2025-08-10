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
    footer {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        text-align: center;
        padding: 10px 0;
        font-size: 12px;
        color: #666;
        background-color: #f4f4f4;
        border-top: 1px solid #ddd;
    }
    
    footer a {
        color: #007BFF;
        text-decoration: none;
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

<div style="margin-top:80px;">
  <p style="font-style: italic; font-size: 14px; color: #888;">This website was developed by Loki. If you get any trouble, just contact the admin (mogilisettilokesh@gmail.com).</p>
  <h1>Vegetables</h1>
  <div id="container"></div>

  <h1>Groceries</h1>
  <div id="container1"></div>

  <h1>Accessories</h1>
  <div id="container2"></div>
</div>

<footer>
    <p>Developed by Loki | Copyrights by 2025</p>
    <p>Contact: <a href="mailto:mogilisettilokesh@gmail.com">mogilisettilokesh@gmail.com</a></p>
</footer>

<script>
  // Function to fetch and display unavailable vegetables
  function veg() {
    var xhttp = new XMLHttpRequest();
    // Use a relative URL instead of a hardcoded absolute one
    var url = "api/getunv";
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

            html += '<div style="display: flex; border: 1px solid black; border-radius: 8px; padding: 15px; margin-bottom: 20px; box-shadow: 1px 1px 3px rgba(0,0,0,0.15); align-items: center;">';
            html += '<div style="flex: 1; font-size: 18px; font-weight: bold; text-transform: uppercase;">' + item.name + '</div>';
            
            // Note for the user
            html += '<div style="font-size: 12px; margin: 0 10px; color: #888;">If you\'re buying, click the button to mark it as purchased.</div>';
            
            // "Buy" button to update the item
            html += '<button onclick="updateStatus(' + item.id + ')" class="available-btn">Buy</button>';
            html += '</div>';
          }
          display.innerHTML = html;
        }
      } else if (this.readyState === 4 && this.status !== 200) {
        console.error("Failed to fetch vegetables. Status:", this.status);
        display.innerHTML = '<div style="text-align: center; margin-top: 50px; color: #dc3545;">Error loading vegetables. Please try again.</div>';
      }
    };
  }

  // Function to fetch and display unavailable general groceries
  function gro() {
    var xhttp = new XMLHttpRequest();
    // Use a relative URL instead of a hardcoded absolute one
    var url = "api/getunvg";
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

            html += '<div style="display: flex; border: 1px solid black; border-radius: 8px; padding: 15px; margin-bottom: 20px; box-shadow: 1px 1px 3px rgba(0,0,0,0.15); align-items: center;">';
            html += '<div style="flex: 1; font-size: 18px; font-weight: bold; text-transform: uppercase;">' + item.name + '</div>';
            
            // Note for the user
            html += '<div style="font-size: 12px; margin: 0 10px; color: #888;">If you\'re buying, click the button to mark it as purchased.</div>';
            
            // "Buy" button now calls the specific updateGroceryStatus function
            html += '<button onclick="updateGroceryStatus(' + item.id + ')" class="available-btn">Buy</button>';
            html += '</div>';
          }
          display.innerHTML = html;
        }
      } else if (this.readyState === 4 && this.status !== 200) {
         console.error("Failed to fetch groceries. Status:", this.status);
         display.innerHTML = '<div style="text-align: center; margin-top: 50px; color: #dc3545;">Error loading groceries. Please try again.</div>';
     }
    };
  }

  // Function to fetch and display unavailable accessories
  function acc() {
    var xhttp = new XMLHttpRequest();
    // Use a relative URL instead of a hardcoded absolute one
    var url = "api/getacunv";
    xhttp.open("GET", url, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send();

    var display = document.getElementById("container2");

    xhttp.onreadystatechange = function () {
      if (this.readyState === 4 && this.status === 200) {
        var data = JSON.parse(this.responseText);

        if (!Array.isArray(data) || data === null || data.length === 0) {
            display.innerHTML = '<div style="text-align: center; margin-top: 50px; color: #666;">No items to display. Add a new item!</div>';
        } else {
          var html = "";

          for (var i = 0; i < data.length; i++) {
            var item = data[i];
            
            html += '<div style="display: flex; border: 1px solid black; border-radius: 8px; padding: 15px; margin-bottom: 20px; box-shadow: 1px 1px 3px rgba(0,0,0,0.15); align-items: center;">';
            html += '<div style="flex: 1; font-size: 18px; font-weight: bold; text-transform: uppercase;">' + item.name + '</div>';

            // Note for the user
            html += '<div style="font-size: 12px; margin: 0 10px; color: #888;">If you\'re buying, click the button to mark it as purchased.</div>';

            // "Buy" button now calls the specific updateAccessoryStatus function
            html += '<button onclick="updateAccessoryStatus(' + item.id + ')" class="available-btn">Buy</button>';
            html += '</div>';
          }
          display.innerHTML = html;
        }
      } else if (this.readyState === 4 && this.status !== 200) {
          console.error("Failed to fetch accessories. Status:", this.status);
          display.innerHTML = '<div style="text-align: center; margin-top: 50px; color: #dc3545;">Error loading accessories. Please try again.</div>';
      }
    };
  }

  // Function to update the status of an item (for vegetables)
  function updateStatus(itemId) {
    var xhttp = new XMLHttpRequest();
    // Use a relative URL instead of a hardcoded absolute one
    var url = "api/updateStatus/" + itemId;
    xhttp.open("PUT", url, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send();

    xhttp.onreadystatechange = function () {
      if (this.readyState === 4 && this.status === 200) {
        alert("Item status updated successfully!");
        load();
      } else if (this.readyState === 4 && this.status !== 200) {
        console.error("Failed to update item status. Status:", this.status);
        alert("Failed to update item status. Please check server logs.");
      }
    };
  }
  
  // Function to update the status of a grocery item
  function updateGroceryStatus(groceryId) {
    var xhttp = new XMLHttpRequest();
    // Use the new relative URL for groceries
    var url = "api/updateGroceryStatus/" + groceryId;
    xhttp.open("PUT", url, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send();

    xhttp.onreadystatechange = function () {
      if (this.readyState === 4 && this.status === 200) {
        alert("Grocery item status updated successfully!");
        load();
      } else if (this.readyState === 4 && this.status !== 200) {
        console.error("Failed to update grocery item status. Status:", this.status);
        alert("Failed to update grocery item status. Please check server logs.");
      }
    };
  }
  
  // NEW: Function to update the status of an accessory item
  function updateAccessoryStatus(accessoryId) {
    var xhttp = new XMLHttpRequest();
    // Use the new relative URL for accessories
    var url = "api/updateAccessoryStatus/" + accessoryId;
    xhttp.open("PUT", url, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send();

    xhttp.onreadystatechange = function () {
      if (this.readyState === 4 && this.status === 200) {
        alert("Accessory item status updated successfully!");
        load();
      } else if (this.readyState === 4 && this.status !== 200) {
        console.error("Failed to update accessory item status. Status:", this.status);
        alert("Failed to update accessory item status. Please check server logs.");
      }
    };
  }

  // The main load function now calls all three functions.
  function load() {
    veg();
    gro();
    acc();
  }
</script>
</body>
</html>
