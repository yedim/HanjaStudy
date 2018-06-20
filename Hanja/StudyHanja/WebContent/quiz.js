
var currentTab = 0; // Current tab is set to be the first tab (0)
showTab(currentTab); // Display the crurrent tab

function showTab(n) {
  var x = document.getElementsByClassName("tab");
  x[n].style.display = "block";
  
  if (n == (x.length - 1)) {
    document.getElementById("nextBtn").innerHTML = "Submit";
  } else {
    document.getElementById("nextBtn").innerHTML = "Next";
  }
}

function nextPrev(n) {
  var x = document.getElementsByClassName("tab");
  x[currentTab].style.display = "none";
  currentTab = currentTab + n;
  if (currentTab >= x.length) {
    document.getElementById("regForm").submit();
    return false;
  }
  showTab(currentTab);
}

function move() {
	  var elem = document.getElementById("myBar");
	  var width = 0;
	  var id = setInterval(frame, 50);
	  function frame() {
	    if (width >= 100) {
	      clearInterval(id);
	      document.getElementById("myP").className = "w3-text-red w3-animate-opacity";
	      document.getElementById("myP").innerHTML = "Times' up";
	    } else {
	      width++;
	      elem.style.width = width + '%';
	      var num = width * 1 / 10;
	      num = num.toFixed(0)
	      document.getElementById("demo").innerHTML = num;
	    }
	  }
}

