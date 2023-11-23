<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0"  charset="UTF-8"/>
    <title>Weather App</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet"/>
</head>
<style>
* {
  padding: 0;
  margin: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
}

:root {
  --white: #ffffff;
  --off-white: #e5e5e5;
  --transp-white-1: rgba(255, 255, 255, 0.25);
  --transp-white-2: rgba(255, 255, 255, 0.1);
  --blue-1: #62b8f5;
  --blue-2: #4475ef;
  --shadow: rgba(3, 46, 87, 0.2);
}

.wrapper {
  font-size: 16px;
  width: 90vw;
  max-width: 28em;
  position: absolute;
  transform: translate(-50%, -50%);
  top: 50%;
  left: 50%;
}
.container1 {
  width: 100%;
  background: var(--transp-white-2);
  backdrop-filter: blur(10px);
  padding: 3em 1.8em;
  border: 2px solid var(--transp-white-2);
  border-radius: 0.6em;
  box-shadow: 0 1.8em 3.7em var(--shadow);
  text-align: center;
}

#result1 h2 {
/*   color: var(--white); */
  text-transform: uppercase;
  letter-spacing: 0.18em;
  font-weight: 600;
  margin: 0.75em 0;
}
.weather,
.desc {
  color: var(--off-white);
  text-transform: uppercase;
  letter-spacing: 0.2em;
  font-size: 0.9em;
  font-weight: 500;
  line-height: 2em;
}
.weather {
  margin-top: -0.7em;
}
#result1 img {
/*   margin: 0.6em 0 0 0; */
  width: 6.2em;
  filter: drop-shadow(0 1.8em 3.7em var(--shadow));
}
#result1 h1 {
  font-size: 4em;
  margin: 0.3em 0 0.7em 0;
  line-height: 0;
  font-weight: 400;
/*   color: var(--white); */
}
.temp-container { 
	display: flex; 
	justify-content: center;
} 
.temp-container div {
  padding: 0.3em 1em;
}
.temp-container div:first-child {
/*   border-right: 1px solid var(--transp-white-1); */
}
.temp-container .title {
  font-weight: 600;
/*   color: var(--white); */
}
.temp-container .temp {
  font-weight: 300;
/*   color: var(--off-white); */
}
.msg {
  margin-top: 1.8em;
  color: var(--white);
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.1em;
}
@media screen and (max-width: 450px) {
  .wrapper {
    font-size: 14px;
  }
}
</style>
<body>
    <div class="wrapper">
      	<div class="container1">
<!--         	<div class="search-container"> -->
<!--           		<input type="text" placeholder="Enter a city name" id="city" value="London" /> -->
<!--           		<button id="search-btn">Search</button> -->
<!--         	</div> -->
        	<div id="result1"></div>
      	</div>
    </div>
</body>
<script>
$(function(){
	// Assign the copied API key to the 'key' variable
	key = "59711f7ca4c18930d18e07d3896036d1";
	
	let result1 = document.getElementById("result1");

	//Function to fetch weather details from api and display them
	let getWeather = () => {
	  //If input field is empty
	  //If input field is NOT empty
	    let url = `https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=\${key}&units=metric&lang=kr`;
	    
//         <h4 style="color: #495057;" class="weather">\${data.weather[0].main}</h4>
	    
	    // Clear the input field
	    fetch(url)
	      .then((resp) => resp.json())
	      // If city name is valid
	      .then((data) => {
	        console.log(data);
	        console.log(data.weather[0].icon);
	        console.log(data.weather[0].main);
	        console.log(data.weather[0].description);
	        console.log(data.name);
	        console.log(data.main.temp_min);
	        console.log(data.main.temp_max);
	        result1.innerHTML = `
	        <h2>서 울</h2>
	        <h4 style="color: #495057;" class="desc">\${data.weather[0].description}</h4>
	        <img src="https://openweathermap.org/img/w/\${data.weather[0].icon}.png">
	        <h4>현재기온</h4>
	        <h4>\${Math.round(data.main.temp)} &#176;</h4>
	        <div class="temp-container">
	            <div>
	                <h6 class="title">최저기온</h6>
	                <h6 class="temp">\${Math.round(data.main.temp_min)}&#176;</h6>
	            </div>
	            <div>
	                <h6 class="title">최고기온</h6>
	                <h6 class="temp">\${Math.round(data.main.temp_max)}&#176;</h6>
	            </div>
	        </div>
	        `;
	      })
	};
	window.addEventListener("load", getWeather);
});
</script>
