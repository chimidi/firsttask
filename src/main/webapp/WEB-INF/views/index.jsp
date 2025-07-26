<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://kit.fontawesome.com/3cbf1090e8.js" crossorigin="anonymous"></script>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Phone Only Page</title>
  <style>
    /* Reset default styles */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    /* Only apply these styles on phone-sized screens */
    @media only screen and (max-width: 480px) {
      body {
        background-color: white;
        font-family: Arial, sans-serif;
        color: #333;
        padding: 20px;
      }

      header {
        text-align: center;
      }
      #block1{
        height:300px;
        width:65%;
        background-color: #dbe0e0 ;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0px 4px 5px 1px;
        text-align: center;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
      }
        
      input[type="radio"] {
        display: none;
      }

      label {
        display: block;
        margin: 15px 0;
        padding: 10px;
        background-color: white;
        border-radius: 8px;
        text-align: center;
        cursor: pointer;
        font-size: 20px;
        font-weight:bold;
        transition: background-color 0.2s ease;
      }

      input[type="radio"]:checked + label {
        background-color: #00796b;
        color: white;
        font-weight: bold;
      }
    }
     

    input[type="radio"] {
      display: none;
    }

    #popup {
      display: none;
      background-color: white;
      border-radius: 12px;
      padding: 20px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
      max-width: 300px;
     position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
      text-align: center;
    }

    #popup input[type="password"] {
      padding: 10px;
      font-size: 16px;
      width: 80%;
      margin-top: 10px;
    }

    #popup button {
      margin-top: 15px;
      padding: 10px 20px;
      font-weight: bold;
      background-color: #00796b;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }
    #popup h2 {
      margin-bottom: 10px;
    }

    .digit-inputs {
      display: flex;
      justify-content: center;
      gap: 10px;
      margin-top: 10px;
    }

    .digit-inputs input {
      width: 40px;
      height: 50px;
      text-align: center;
      font-size: 24px;
      border: 2px solid #00796b;
      border-radius: 6px;
    }

    #popup button {
      margin-top: 20px;
      padding: 10px 20px;
      font-weight: bold;
      background-color: #00796b;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }
  </style>
</head>
<body>
  <header>
    <h1  style="position:relative;top:240px;color:black;"  >HOMEIN <i class="fa-solid fa-house"></i></h1>
  </header>
   <br>
  <main>
    
    <div id="block1">
    <form>
          <input type="radio" name="person" id="alice" value="lokesh">
      <label for="alice">Lokesh</label>

      <input type="radio" name="person" id="bob" value="tanusha">
      <label for="bob">Tanusha</label>

      <input type="radio" name="person" id="charlie" value="suresh">
      <label for="charlie">Suresh</label>

      <input type="radio" name="person" id="diana" value="bhargavi">
      <label for="diana">Bhargavi</label>

    </form>
    </div>
    
    <div id="popup">
  <h2 id="selectedName"></h2>
  <p id="error">Enter your 4-digit password:</p>
  <div class="digit-inputs">
    <input type="text" maxlength="1" inputmode="numeric" />
    <input type="text" maxlength="1" inputmode="numeric" />
    <input type="text" maxlength="1" inputmode="numeric" />
    <input type="text" maxlength="1" inputmode="numeric" />
  </div>
  <button onclick=login() >LOGIN</button>
</div>

<script>
  const radios = document.querySelectorAll('input[type="radio"]');
  const block1 = document.getElementById('block1');
  const popup = document.getElementById('popup');
  const selectedNameEl = document.getElementById('selectedName');
  const inputs = document.querySelectorAll('.digit-inputs input');
  var n1;
  radios.forEach(radio => {
    radio.addEventListener('change', () => {
      const name = radio.value;
      n1 = name;
      block1.style.display = 'none';
      selectedNameEl.textContent = name;
      popup.style.display = 'block';
      inputs[0].focus();
    });
  });

  // Auto-jump between inputs
  let code = ''; // This will hold the 4-digit code

inputs.forEach((input, index) => {
  input.addEventListener('input', () => {
    if (input.value.length === 1 && index < inputs.length - 1) {
      inputs[index + 1].focus();
    }

    // Update the code every time input changes
    code = Array.from(inputs).map(inp => inp.value).join('');
  });

  input.addEventListener('keydown', (e) => {
    if (e.key === 'Backspace' && input.value === '' && index > 0) {
      inputs[index - 1].focus();
    }

    // Also update code here in case of deletion
    setTimeout(() => {
      code = Array.from(inputs).map(inp => inp.value).join('');
    }, 0);
  });
});

  
  function login()
  {
	  const codeStr = Array.from(inputs).map(inp => inp.value).join('');
	  const codeInt = parseInt(codeStr);  // Convert to integer
	  const nameStr = String(n1); 
	  if (isNaN(codeInt) || codeStr.length !== 4) {
		  error.innerHTML = "Please enter 4 digits";
		  error.style.color = "red";
		    return;
		  }// Ensure n1 is a string
	  var xhtml = new XMLHttpRequest();
	  var url = "https://firsttask-jmub.onrender.com/api/login/"+codeInt+"/"+nameStr; // if no SSL enabled on server
		xhtml.open("GET", url, true);
		xhtml.setRequestHeader('Content-Type','application/json'); 
		xhtml.send();
		xhtml.onreadystatechange = function()
		{
			if(this.readyState == 4 && this.status == 200)
			{
				if(this.responseText == "error.jsp")
					{
					error.innerHTML = "Invaild passcode";
					  error.style.color = "red";
					}
					else{
						window.location.replace(this.responseText);
					}
			}
				
		};
  }
  
</script>
    
  </main>
</body>
</html>