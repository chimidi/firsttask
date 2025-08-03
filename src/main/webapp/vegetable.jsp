<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://kit.fontawesome.com/3cbf1090e8.js" crossorigin="anonymous"></script>
<meta charset="ISO-8859-1">
<title>vegetables</title>
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
    .header-content i {
      margin:10px;
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

/* Specific styling for multi-select to show multiple rows - REMOVE OR KEEP FOR REFERENCE IF NEEDED */
/* #addItemForm select[multiple] {
    height: 100px; 
    overflow-y: auto;
} */

#addItemForm input[type="checkbox"] {
    margin-right: 8px;
    transform: scale(1.2); /* Make checkbox slightly larger */
}

#addItemForm .checkbox-label {
    display: inline-block;
    font-weight: normal; /* Override bold for checkbox label */
}

/* NEW: Styles for the roommate checkboxes */
.roommate-checkbox-group label {
    display: inline-block; /* Keep label and checkbox on the same line */
    margin-right: 15px; /* Space between checkboxes */
    font-weight: normal; /* Don't bold the individual roommate names */
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
</style>

</head>
<body onload="historylist()">
<header>
<div class="header-content">
    <h1><i class="fa-solid fa-house"></i> HOMEIN</h1>
    <i style="font-size:10px;" class="fa-solid fa-right-from-bracket"> Logout</i>

  </div>
</header>

	<div>
	  <ul>
	    <li>If it is <span style="color:green;">GREEN</span>, it means the item is available. If not, just click on it to mark it as not available.</li>
	    <li>If it is <span style="color:red;">RED</span>, it means the item is not available.</li>
	    <li>The letter at the end of the block indicates where in the cart the item belongs  it reflects the first letter of the buyer's name.</li>
	  </ul>
	</div>
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
    <h2>Add New Item</h2>
    <form id="addItemForm">
      <div>
        <label for="itemName">Item Name:</label>
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


</body>
<script type="text/javascript">

// Renamed 'name' variable and function to avoid conflicts
let loggedInUserName = null;
function fetchLoggedInUserName()
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
		            loggedInUserName = this.responseText;
			     else
			    	window.location.replace(this.responseText);

		}
	};
}

// Global variables to store the item ID and name for the update function
let currentItemId = null;
let currentItemName = null;

// Array of known roommates for the dropdowns
// In a real application, you'd fetch this from your backend via a /api/roommates endpoint.
const roommates = [
    { id: 1, name: "Lokesh" },
    { id: 2, name: "Tanusha" },
    { id: 3, name: "Suresh" },
    { id: 4, name: "Bhargavi" }
];


// Attach event listeners for the popup buttons once the DOM is fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Existing "Not Available" popup buttons
    document.getElementById("closePopupBtn").addEventListener("click", closePopup);
    document.getElementById("confirmUpdateBtn").addEventListener("click", handleConfirmUpdate);

    // NEW: Add Item Modal buttons
    document.getElementById("bottomGreenButton").addEventListener("click", openAddItemModal);
    document.getElementById("cancelAddItemBtn").addEventListener("click", closeAddItemModal);
    document.getElementById("submitAddItemBtn").addEventListener("click", submitNewItem);

    // NEW: Listener for "Visible to All" checkbox to control specific roommate checkboxes
    const visibleToAllCheckbox = document.getElementById("visibleToAllCheckbox");
    const addVisibleToCheckboxesContainer = document.getElementById("addVisibleToCheckboxes");

    visibleToAllCheckbox.addEventListener('change', function() {
        // Get all individual roommate checkboxes
        const roommateCheckboxes = addVisibleToCheckboxesContainer.querySelectorAll('input[type="checkbox"]');
        roommateCheckboxes.forEach(checkbox => {
            checkbox.disabled = this.checked; // Disable if "Visible to All" is checked
            if (this.checked) {
                checkbox.checked = false; // Uncheck all if "Visible to All" is checked
            }
        });
        // Also disable/enable the container visually (optional)
        if (this.checked) {
            addVisibleToCheckboxesContainer.classList.add('disabled-container'); // Add a class for styling
            addVisibleToCheckboxesContainer.style.opacity = '0.6'; // Dim it
            addVisibleToCheckboxesContainer.style.pointerEvents = 'none'; // Prevent clicks
        } else {
            addVisibleToCheckboxesContainer.classList.remove('disabled-container');
            addVisibleToCheckboxesContainer.style.opacity = '1';
            addVisibleToCheckboxesContainer.style.pointerEvents = 'auto';
        }
    });

    // Populate dropdowns and checkboxes on page load
    populatePurchasedByDropdown();
    populateVisibleToCheckboxes(); // Populate the new checkbox group

    // Initial state setup for roommate checkboxes
    visibleToAllCheckbox.dispatchEvent(new Event('change')); // Trigger initial change event to set correct disabled state

    // You might also want to call fetchLoggedInUserName() here if needed on page load
    // fetchLoggedInUserName();
});


function historylist() {
	  var xhttp = new XMLHttpRequest();
	  var url = "https://firsttask-production.up.railway.app/api/getitems";
	  xhttp.open("GET", url, true);
	  xhttp.setRequestHeader('Content-Type', 'application/json');
	  xhttp.send();

	  var display = document.getElementById("container");

	  xhttp.onreadystatechange = function () {
	    if (this.readyState === 4 && this.status === 200) {
	      var data = JSON.parse(this.responseText);

	      // Check if data is not an array, is null, or an empty array
	      if (!Array.isArray(data) || data === null || data.length === 0) {
	          window.location.replace("index.jsp");
	      } else {
	        var html = "";

	        for (var i = 0; i < data.length; i++) {
	          var item = data[i];
	          // Ensure purchasedBy exists before accessing its properties
	          var purchaser = item.purchasedBy ? item.purchasedBy.name : "Unknown";
	          var isAvailable = item.isAvailable;
	          var availabilityText = isAvailable ? "AVAILABLE" : "NOT AVAILABLE";
	          var availabilityColor = isAvailable ? "#d4edda" : "#f8d7da";   // green/red backgrounds
	          var availabilityTextColor = isAvailable ? "#155724" : "#721c24"; // dark green/red text

	          html += '<div style="display: flex; border: 1px solid black; border-radius: 8px; padding: 15px; margin-bottom: 20px; box-shadow: 1px 1px 3px rgba(0,0,0,0.15); align-items: center;">';

	          // Name block - uppercase, bold, font size 18px
	          html += '<div style="flex: 1; font-size: 18px; font-weight: bold; text-transform: uppercase;">' + item.name + '</div>';

	          // Availability block - button if available, div if not available
	          if (isAvailable) {
	            // Pass the item ID and name to the update function
	            html += '<button onclick="update(\'' + item.id + '\', \'' + item.name + '\')" style="flex: 1; background-color: ' + availabilityColor + '; color: ' + availabilityTextColor + '; padding: 8px 12px; border-radius: 4px; font-weight: bold; border: none; cursor: pointer; font-size: 14px; text-align: center;">' + availabilityText + '</button>';
	          } else {
	            html += '<div style="flex: 1; background-color: ' + availabilityColor + '; color: ' + availabilityTextColor + '; padding: 8px 12px; border-radius: 4px; font-weight: bold; font-size: 14px; text-align: center;">' + availabilityText + '</div>';
	          }

	          // Purchased By block - smaller font, right aligned
	          html += '<div style="flex: 1; font-size: 14px; color: #555; text-align: right;">Purchased by: ' + purchaser + '</div>';

	          html += '</div>';
	        }

	        display.innerHTML = html;
	      }
	    }
	  };
	}

function update(id, itemName) {
    // Store the ID and name for later use (e.g., by the confirm update button)
    currentItemId = id;
    currentItemName = itemName;

    // Get the popup elements
    var popupModal = document.getElementById("popupModal");
    var popupItemName = document.getElementById("popupItemName");

    // Set the item name in the popup
    popupItemName.textContent = itemName;

    // Display the popup
    popupModal.style.display = "flex"; // Use "flex" to center content
}

function handleConfirmUpdate() {
    // This is where you would send an API call to your backend
    // to mark the item (currentItemId) as "not available".
    alert("Simulating update for item: " + currentItemName + " (ID: " + currentItemId + "). This would now interact with your backend.");
    // After successful update, you might want to close the popup and refresh the list
    closePopup();
    // historylist(); // Uncomment this line to refresh the list after update
}

function closePopup() {
    var popupModal = document.getElementById("popupModal");
    popupModal.style.display = "none"; // Hide the popup
    // Clear stored item details when closing
    currentItemId = null;
    currentItemName = null;
}

// NEW FUNCTIONS FOR ADD ITEM MODAL
function openAddItemModal() {
    document.getElementById("addItemModal").style.display = "flex";
    // Reset form fields when opening
    document.getElementById("addItemForm").reset();
    document.getElementById("addIsAvailable").checked = true; // Default to available

    // Reset visible to all checkbox and specific roommate checkboxes
    const visibleToAllCheckbox = document.getElementById("visibleToAllCheckbox");
    visibleToAllCheckbox.checked = true; // Default to "Visible to All"
    // Manually trigger change event to disable/clear roommate checkboxes
    visibleToAllCheckbox.dispatchEvent(new Event('change'));

    // Ensure purchased by dropdown has default selected
    const purchasedBySelect = document.getElementById("addPurchasedBy");
    purchasedBySelect.value = ""; // Set to the value of your default option
}

function closeAddItemModal() {
    document.getElementById("addItemModal").style.display = "none";
}

function populatePurchasedByDropdown() {
    const purchasedBySelect = document.getElementById("addPurchasedBy");
    purchasedBySelect.innerHTML = ''; // Clear existing options

    // Add a default blank/placeholder option
    const defaultOption = document.createElement("option");
    defaultOption.value = "";
    defaultOption.textContent = "-- Select Purchaser --";
    defaultOption.disabled = true; // Make it unselectable
    defaultOption.selected = true; // Select by default
    purchasedBySelect.appendChild(defaultOption);

    roommates.forEach(roommate => {
        const option = document.createElement("option");
        option.value = roommate.id;
        option.textContent = roommate.name;
        purchasedBySelect.appendChild(option);
    });
}

// NEW: Function to populate the "Visible to Specific Roommates" checkboxes
function populateVisibleToCheckboxes() {
    const checkboxContainer = document.getElementById("addVisibleToCheckboxes");
    checkboxContainer.innerHTML = ''; // Clear existing checkboxes

    roommates.forEach(roommate => {
        const div = document.createElement("div"); // Wrap each checkbox in a div for layout
        const checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.id = "roommate_" + roommate.id; // Unique ID for each checkbox
        checkbox.name = "visibleRoommates"; // Common name for easy selection
        checkbox.value = roommate.id; // The roommate's ID

        const label = document.createElement("label");
        label.htmlFor = "roommate_" + roommate.id;
        label.textContent = roommate.name;

        div.appendChild(checkbox);
        div.appendChild(label);
        checkboxContainer.appendChild(div);
    });
}

function submitNewItem() {
    const itemName = document.getElementById("addItemName").value;
    const isAvailable = document.getElementById("addIsAvailable").checked;
    const visibleToAll = document.getElementById("visibleToAllCheckbox").checked;
    const purchasedBy = document.getElementById("addPurchasedBy").value;

    if (!itemName) {
        alert("Please enter an item name.");
        return;
    }
    if (!purchasedBy) {
        alert("Please select who purchased the item.");
        return;
    }

    let selectedVisibilityUserIds = [];
    if (!visibleToAll) { // If "Visible to All" is NOT checked, get specific selections from checkboxes
        const roommateCheckboxes = document.querySelectorAll('#addVisibleToCheckboxes input[type="checkbox"]');
        roommateCheckboxes.forEach(checkbox => {
            if (checkbox.checked) {
                selectedVisibilityUserIds.push(parseInt(checkbox.value));
            }
        });
        if (selectedVisibilityUserIds.length === 0) {
            alert("Please select at least one roommate for specific visibility, or check 'Visible to All'.");
            return;
        }
    }

    // Prepare data for the backend
    const newItemData = {
        name: itemName,
        isAvailable: isAvailable,
        visibleToAll: visibleToAll, // Send the boolean from the checkbox
        purchasedBy: parseInt(purchasedBy), // Send just the ID for purchasedBy
        visibleToUsers: selectedVisibilityUserIds // Send array of IDs for specific visibility
    };

    console.log("New Item Data to be sent:", newItemData);

    // --- Start of AJAX call to backend ---
    var xhttp = new XMLHttpRequest();
    var url = "https://firsttask-production.up.railway.app/api/items"; // New API endpoint to create item
    xhttp.open("POST", url, true);
    xhttp.setRequestHeader('Content-Type', 'application/json');

    xhttp.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200 || this.status === 201) { // 200 OK or 201 Created
                alert("Item added successfully!");
                closeAddItemModal();
                historylist(); // Refresh the list to show the new item
            } else {
                alert("Error adding item: " + this.status + " " + this.responseText);
                console.error("Error adding item:", this.responseText);
            }
        }
    };
    xhttp.send(JSON.stringify(newItemData));
    // --- End of AJAX call ---
}

</script>
</html>