<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/3cbf1090e8.js" crossorigin="anonymous"></script>
<meta charset="ISO-8859-1">
<title>Groceries</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    /* Your existing CSS styles go here (make sure they are copied from vegetable.jsp if not already there) */
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
      cursor: pointer;
    }
    .header-content i {
      margin:10px;
    }
    .logout-text {
      font-size: 10px;
      cursor: pointer;
    }


    #block {
	  width: 100%;
	  height: 50px;
	  background-color: white;
	  border: 1px solid #ccc;
	  border-radius: 6px;
	  margin-top: 20px;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  font-weight: bold;
	  font-size: 16px;
	  color: #333;
}
.item-row {
    display: flex;
    align-items: center;
    background: #fff;
    margin-bottom: 12px;
    padding: 12px 16px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
  }
  .item-name {
    flex: 1;
    font-weight: bold;
    font-size: 18px;
    color: #333;
    text-transform: uppercase;
  }
  .item-availability {
    flex: 1;
    text-align: center;
  }
  .item-availability button {
    padding: 8px 20px;
    border: none;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    color: white;
  }
  .available-btn {
    background-color: #28a745; /* green */
  }
  .not-available {
    background-color: #dc3545; /* red */
    color: white;
    padding: 8px 20px;
    border-radius: 6px;
    font-weight: 600;
  }
  .item-purchasedby {
    flex: 1;
    text-align: right;
    color: #555;
    font-size: 16px;
  }

   /* Existing Popup styles (for "Not Available" confirmation) */
  #popupModal {
    display: none;
    position: fixed;
    z-index: 9999;
    left: 0; top: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,0.4);
    justify-content: center;
    align-items: center;
  }
  #popupContent {
    background: white;
    padding: 20px 30px;
    border-radius: 8px;
    max-width: 300px;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.25);
  }
  #popupContent h2 {
    margin-bottom: 10px;
    color: #333;
  }
  #popupContent p {
    margin-bottom: 20px;
    font-size: 16px;
    color: #555;
  }
  #popupContent button {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    margin: 5px;
  }
  #confirmUpdateBtn {
    background-color: #007bff;
    color: white;
  }
  #closePopupBtn {
    background-color: #6c757d;
    color: white;
  }

    body {
  padding-top: 65px;
}

/* Style for the green button at the bottom */
#bottomGreenButton {
    display: block;
    width: fit-content;
    margin: 30px auto;
    padding: 15px 30px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    transition: background-color 0.3s ease;
}

#bottomGreenButton:hover {
    background-color: #218838;
}

/* NEW: Styles for the Add Item Modal */
#addItemModal {
    display: none; /* Hidden by default */
    position: fixed;
    z-index: 10000; /* Higher than existing popupModal */
    left: 0; top: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,0.6); /* Darker overlay */
    justify-content: center;
    align-items: center;
}

#addItemContent {
    background: white;
    padding: 30px;
    border-radius: 8px;
    max-width: 400px;
    width: 90%; /* Responsive width */
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    text-align: left; /* Align form labels to the left */
}

#addItemContent h2 {
    text-align: center;
    margin-bottom: 25px;
    color: #333;
}

#addItemForm div {
    margin-bottom: 15px;
}

#addItemForm label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
    color: #555;
}

#addItemForm input[type="text"],
#addItemForm select {
    width: calc(100% - 22px); /* Full width minus padding and border */
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
}

#addItemForm input[type="checkbox"] {
    margin-right: 8px;
    transform: scale(1.2); /* Make checkbox slightly larger */
}

#addItemForm .checkbox-label {
    display: inline-block;
    font-weight: normal; /* Override bold for checkbox label */
}

/* NEW: Styles for the roomate checkboxes */
.roommate-checkbox-group label {
    display: inline-block; /* Keep label and checkbox on the same line */
    margin-right: 15px; /* Space between checkboxes */
    font-weight: normal; /* Don't bold the individual roomate names */
    margin-bottom: 0; /* Adjust margin if needed */
}
.roommate-checkbox-group input[type="checkbox"] {
    transform: scale(1.0); /* Adjust size if necessary */
    margin-right: 5px;
}
.roommate-checkbox-group {
    border: 1px solid #eee; /* Light border for the group */
    padding: 10px;
    border-radius: 4px;
    background-color: #f9f9f9;
}


#addItemButtons {
    text-align: right; /* Align buttons to the right */
    margin-top: 25px;
}

#addItemButtons button {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    margin-left: 10px; /* Space between buttons */
}

#submitAddItemBtn {
    background-color: #28a745; /* Green for submit */
    color: white;
}

#cancelAddItemBtn {
    background-color: #6c757d; /* Gray for cancel */
    color: white;
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
<body onload="historylist()">
<header>
<div class="header-content">
    <h1 onclick="goToIndex()"><i class="fa-solid fa-house"></i> HOMEIN</h1>
    <span class="logout-text" onclick="logout()"><i class="fa-solid fa-right-from-bracket"></i> Logout</span>

  </div>
</header>

	<div>
	  <ul>
	    <li>If it is <span style="color:green;">GREEN</span>, it means the item is available. If not, just click on it to mark it as not available.</li>
	    <li>If it is <span style="color:red;">RED</span>, it means the item is not available.</li>
	    <li>The letter at the end of the block indicates where in the cart the item belongs it reflects the first letter of the buyer's name.</li>
	  </ul>
	</div>
	<br>

     <h3 style="text-align:center">GROCERIES <i class="fa-solid fa-bowl-rice"></i></h3>
    <br>
    
	<div id="container">

	</div>

<div id="popupModal">
  <div id="popupContent">
    <h2 id="popupItemName"></h2>
    <p>It is not available.</p>
    <button id="confirmUpdateBtn">Update</button>
    <button id="closePopupBtn">Close</button>
  </div>
</div>

<button id="bottomGreenButton" onclick="openAddItemModal()">Add New Item</button>

<div id="addItemModal">
  <div id="addItemContent">
    <h2>Add New Grocery Item</h2>
    <form id="addItemForm">
      <div>
        <label for="itemName">Grocery Name:</label>
        <input type="text" id="addItemName" required>
      </div>
      <div>
        <label for="isAvailable">Is Available:</label>
        <input type="checkbox" id="addIsAvailable" checked> <span class="checkbox-label">Yes, it is available</span>
      </div>
      
      <div>
        <label for="visibleToAllCheckbox">Visible to All:</label>
        <input type="checkbox" id="visibleToAllCheckbox" checked> <span class="checkbox-label"></span>
      </div>
      
      <div id="specificVisibilityContainer">
        <label>Visible to Specific Roommates:</label>
        <div id="addVisibleToCheckboxes" class="roommate-checkbox-group" disabled>
          </div>
      </div>

      <div>
        <label for="purchasedBy">Purchased By:</label>
        <select id="addPurchasedBy">
          </select>
      </div>
      <div id="addItemButtons">
        <button type="button" id="submitAddItemBtn">Submit</button>
        <button type="button" id="cancelAddItemBtn">Cancel</button>
      </div>
    </form>
  </div>
</div>
<footer>
    <p>Developed by Loki | Copyrights by 2025</p>
    <p>Contact: <a href="mailto:mogilisettilokesh@gmail.com">mogilisettilokesh@gmail.com</a></p>
</footer>

</body>
<script type="text/javascript">

// This array now accurately reflects your Roomates table structure (int id, String name)
const roommates = [
    { id: 1, name: "Lokesh" },
    { id: 2, name: "Tanusha" },
    { id: 3, name: "Suresh" },
    { id: 4, name: "Bhargavi" }
];


// Global variables for update function
let currentGroceryId = null;
let currentGroceryName = null;

document.addEventListener('DOMContentLoaded', function() {
    // Popup buttons
    document.getElementById("closePopupBtn").addEventListener("click", closePopup);
    document.getElementById("confirmUpdateBtn").addEventListener("click", handleConfirmUpdate);

    // Add Item Modal buttons
    document.getElementById("bottomGreenButton").addEventListener("click", openAddItemModal);
    document.getElementById("cancelAddItemBtn").addEventListener("click", closeAddItemModal);
    document.getElementById("submitAddItemBtn").addEventListener("click", submitNewGrocery);

    // Listener for "Visible to All" checkbox
    const visibleToAllCheckbox = document.getElementById("visibleToAllCheckbox");
    const addVisibleToCheckboxesContainer = document.getElementById("addVisibleToCheckboxes");

    visibleToAllCheckbox.addEventListener('change', function() {
        const roommateCheckboxes = addVisibleToCheckboxesContainer.querySelectorAll('input[type="checkbox"]');
        roommateCheckboxes.forEach(checkbox => {
            checkbox.disabled = this.checked;
            if (this.checked) {
                checkbox.checked = false;
            }
        });
        if (this.checked) {
            addVisibleToCheckboxesContainer.classList.add('disabled-container');
            addVisibleToCheckboxesContainer.style.opacity = '0.6';
            addVisibleToCheckboxesContainer.style.pointerEvents = 'none';
        } else {
            addVisibleToCheckboxesContainer.classList.remove('disabled-container');
            addVisibleToCheckboxesContainer.style.opacity = '1';
            addVisibleToCheckboxesContainer.style.pointerEvents = 'auto';
        }
    });

    // Populate dropdowns and checkboxes on page load
    populatePurchasedByDropdown();
    populateVisibleToCheckboxes();
    visibleToAllCheckbox.dispatchEvent(new Event('change')); // Trigger initial state

    // Fetch and display groceries
    historylist();
});


function historylist() 
{
	fetchLoggedInUserName();
	var xhttp = new XMLHttpRequest();
    var url = "https://firsttask-jmub.onrender.com/api/groceries";
    xhttp.open("GET", url, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');
    xhttp.send();

    var display = document.getElementById("container");

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            var data = JSON.parse(this.responseText);

            if (!Array.isArray(data) || data === null || data.length === 0) {
                display.innerHTML = '<div style="text-align: center; margin-top: 50px; color: #666;">No groceries to display. Add a new item!</div>';
            } else {
                var html = "";
                for (var i = 0; i < data.length; i++) {
                    var grocery = data[i];
                    var purchaser = grocery.purchasedBy ? grocery.purchasedBy : "Unknown";
                    var isAvailable = grocery.isAvailable;
                    var availabilityText = isAvailable ? "AVAILABLE" : "NOT AVAILABLE";
                    var availabilityColor = isAvailable ? "#d4edda" : "#f8d7da";
                    var availabilityTextColor = isAvailable ? "#155724" : "#721c24";

                    html += '<div style="display: flex; border: 1px solid black; border-radius: 8px; padding: 15px; margin-bottom: 20px; box-shadow: 1px 1px 3px rgba(0,0,0,0.15); align-items: center;">';
                    html += '<div style="flex: 1; font-size: 18px; font-weight: bold; text-transform: uppercase;">' + grocery.name + '</div>';

                    if (isAvailable) {
                        html += '<button onclick="updateGrocery(\'' + grocery.id + '\', \'' + grocery.name + '\')" style="flex: 1; background-color: ' + availabilityColor + '; color: ' + availabilityTextColor + '; padding: 8px 12px; border-radius: 4px; font-weight: bold; border: none; cursor: pointer; font-size: 14px; text-align: center;">' + availabilityText + '</button>';
                    } else {
                        html += '<div style="flex: 1; background-color: ' + availabilityColor + '; color: ' + availabilityTextColor + '; padding: 8px 12px; border-radius: 4px; font-weight: bold; font-size: 14px; text-align: center;">' + availabilityText + '</div>';
                    }

                    html += '<div style="flex: 1; font-size: 14px; color: #555; text-align: right;">Purchased by: ' + purchaser + '</div>';
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

function updateGrocery(id, groceryName) {
    currentGroceryId = id;
    currentGroceryName = groceryName;

    var popupModal = document.getElementById("popupModal");
    var popupItemName = document.getElementById("popupItemName");

    popupItemName.textContent = groceryName;
    popupModal.style.display = "flex";
}

function handleConfirmUpdate() {
    if (currentGroceryId === null) {
        alert("No grocery selected for update.");
        closePopup();
        return;
    }

    var xhttp = new XMLHttpRequest();
    var url = "https://firsttask-jmub.onrender.com/api/groceries/" + currentGroceryId + "/unavailable";
    xhttp.open("PUT", url, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                alert("Grocery '" + currentGroceryName + "' marked as not available.");
                closePopup();
                historylist(); // Refresh the list
            } else if (this.status === 404) {
                alert("Error: Grocery not found. " + this.responseText);
                console.error("Error updating grocery:", this.responseText);
            } else {
                alert("Error updating grocery: " + this.status + " " + this.responseText);
                console.error("Error updating grocery:", this.responseText);
            }
        }
    };
    xhttp.send();
}

function closePopup() {
    var popupModal = document.getElementById("popupModal");
    popupModal.style.display = "none";
    currentGroceryId = null;
    currentGroceryName = null;
}

function openAddItemModal() {
    document.getElementById("addItemModal").style.display = "flex";
    document.getElementById("addItemForm").reset();
    document.getElementById("addIsAvailable").checked = true;

    const visibleToAllCheckbox = document.getElementById("visibleToAllCheckbox");
    visibleToAllCheckbox.checked = true;
    visibleToAllCheckbox.dispatchEvent(new Event('change'));

    const purchasedBySelect = document.getElementById("addPurchasedBy");
    purchasedBySelect.value = "";
}

function closeAddItemModal() {
    document.getElementById("addItemModal").style.display = "none";
}

function populatePurchasedByDropdown() {
    const purchasedBySelect = document.getElementById("addPurchasedBy");
    purchasedBySelect.innerHTML = '';

    const defaultOption = document.createElement("option");
    defaultOption.value = "";
    defaultOption.textContent = "-- Select Purchaser --";
    defaultOption.disabled = true;
    defaultOption.selected = true;
    purchasedBySelect.appendChild(defaultOption);

    roommates.forEach(roommate => {
        const option = document.createElement("option");
        option.value = roommate.id; // roommate.id is an int
        option.textContent = roommate.name;
        purchasedBySelect.appendChild(option);
    });
}

function populateVisibleToCheckboxes() {
    const checkboxContainer = document.getElementById("addVisibleToCheckboxes");
    checkboxContainer.innerHTML = '';

    roommates.forEach(roommate => {
        const div = document.createElement("div");
        const checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.id = "roommate_" + roommate.id;
        checkbox.name = "visibleRoommates";
        checkbox.value = roommate.id; // roommate.id is an int

        const label = document.createElement("label");
        label.htmlFor = "roommate_" + roommate.id;
        label.textContent = roommate.name;

        div.appendChild(checkbox);
        div.appendChild(label);
        checkboxContainer.appendChild(div);
    });
}

function submitNewGrocery() {
    const groceryName = document.getElementById("addItemName").value;
    const isAvailable = document.getElementById("addIsAvailable").checked;
    const visibleToAll = document.getElementById("visibleToAllCheckbox").checked;
    const purchasedBy = document.getElementById("addPurchasedBy").value; // This will be a string number from HTML select

    if (!groceryName) {
        alert("Please enter a grocery name.");
        return;
    }
    if (!purchasedBy) {
        alert("Please select who purchased the grocery.");
        return;
    }

    let selectedVisibilityRoomateIds = [];
    if (!visibleToAll) {
        const roommateCheckboxes = document.querySelectorAll('#addVisibleToCheckboxes input[type="checkbox"]');
        roommateCheckboxes.forEach(checkbox => {
            if (checkbox.checked) {
                // Parse to int, as backend expects Integer
                selectedVisibilityRoomateIds.push(parseInt(checkbox.value));
            }
        });
        if (selectedVisibilityRoomateIds.length === 0) {
            alert("Please select at least one roommate for specific visibility, or check 'Visible to All'.");
            return;
        }
    }

    const newGroceryData = {
        name: groceryName,
        isAvailable: isAvailable,
        visibleToAll: visibleToAll,
        purchasedBy: parseInt(purchasedBy), // Parse to int, as backend expects Integer
        visibleToRoomates: selectedVisibilityRoomateIds // Changed name
    };

    console.log("New Grocery Data to be sent:", newGroceryData);

    var xhttp = new XMLHttpRequest();
    var url = "https://firsttask-jmub.onrender.com/api/groceries";
    xhttp.open("POST", url, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200 || this.status === 201) {
                alert("Grocery added successfully!");
                closeAddItemModal();
                historylist();
            } else {
                alert("Error adding grocery: " + this.status + " " + this.responseText);
                console.error("Error adding grocery:", this.responseText);
            }
        }
    };
    xhttp.send(JSON.stringify(newGroceryData));
}

function goToIndex() {
    window.location.replace("home.jsp");
}

function logout() {
    window.location.replace("index.jsp");
}

function fetchLoggedInUserName()
{
	var xhtml = new XMLHttpRequest();
	var url = "https://firsttask-jmub.onrender.com/api/loginstatus";
	xhtml.open("GET", url, true);
	xhtml.setRequestHeader('Content-Type','application/json');
	xhtml.send();
	xhtml.onreadystatechange = function()
	{
		if(this.readyState == 4 && this.status == 200)
		{
			     if(this.responseText!="index.jsp")
		         document.getElementById("loggedInUserNameDisplay").innerHTML =this.responseText;
			     else
			    	window.location.replace(this.responseText);

		}
	};
}


</script>
</html>