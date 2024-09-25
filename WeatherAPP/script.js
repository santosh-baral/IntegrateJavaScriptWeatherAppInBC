let weather ={
    "apikey": "4e47a6d6b82b6dec3acf0fc0a1430b8e",
    fetchweather: function (city)
    {
        fetch(
            "https://api.openweathermap.org/data/2.5/weather?q="
            + city 
            + "&units=metric&appid=" 
            + this.apikey 
        ).then((response) => response.json())
        .then((data) => {
            if (data.cod === "404") {
                this.displayError(data.message);
            } else {
                this.displayweather(data);
                this.clearError();
            }
        });
    },
    displayweather: function(data){
        const { name }= data;
        const { icon, description }= data.weather[0];
        const { temp, humidity }= data.main;
        const { speed }= data.wind;
        const {lon,lat}=data.coord;
        showcoordinate(lon, lat);
        // console.log(name,icon,description,temp,humidity,speed)
        document.querySelector(".city").innerText="Weather in " + name;
        document.querySelector(".icon").src="https://openweathermap.org/img/wn/" + icon + "@2x.png";
        document.querySelector(".description").innerText= description;
        document.querySelector(".temp").innerText="Temp: "+ temp + "°C";
        document.querySelector(".humidity").innerText="Humidity: " + humidity + "%";
        document.querySelector(".wind").innerText="wind speed: " + speed +"km/hr";
    },
    displayError: function(message) {
        document.querySelector(".error").innerText = message;
    },

    clearError: function() {
        document.querySelector(".error").innerText = "";
    },
    search:function (){
        this.fetchweather(document.querySelector(".search-bar").value);
    },
    init: function() {
        this.fetchweather("pokhara");
    }
    ,
};

document.addEventListener("DOMContentLoaded", function() {
    weather.init();
});

function getcity(address)
{
    weather.fetchweather(address);   
}

function showcoordinate(longitude,latitude)
{
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("showcoordinate", [{
        longi: longitude,
        lati: latitude,
    }]);
    showLocation(longitude,latitude)
}
// var loca=document.getElementById("location");
function getlocation()
    {
        if (navigator.geolocation)
            {
                navigator.geolocation.getCurrentPosition(showposition,showerror);
            }
        else{
            loca.innerHTML="The browser doesnot support location";

        }

    }
function showposition(position)
{
    console.log("LongandLat",position.coords.latitude,position.coords.longitude)
    showLocation(position.coords.longitude,position.coords.latitude,);
}
var permission=document.querySelector(".error");
function showerror(error)
{
    if(error.PERMISSION_DENIED)
    {
        permission.innerHTML="User doesnot give the permission ";
    }
}
let address=document.getElementById("Address");
var City;
const showLocation = async (longitude,latitude) => {
    // console.log('latitude',latitude);

    try {
        // console.log('latitude',latitude);
        const response = await fetch(
            `https://nominatim.openstreetmap.org/reverse?lat=${latitude}&lon=${longitude}&format=json`
        );
        console.log('latitude is 1',latitude);
        
        const data = await response.json();
        if (data.error) {
            console.error(data.error);
            return;
        }
        const { type,name }= data;
        const{ road,municipality,country,state}=data.address;
        console.log('name',type,road,municipality,country,state);
        document.querySelector(".country").innerText="Country : " + country;
        document.querySelector(".state").innerText="State : " + state ;
        document.querySelector(".municipality").innerText="Municipality : " + municipality;
        document.querySelector(".name").innerText="Name :" + name ;
        document.querySelector(".addressType").innerText= "Address Type :" + type;    
    } 
    catch (error) {
        address.innerText = "Unable to fetch location details";
    }
  };

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);
