controladdin MyControlAddIn
{
    RequestedHeight = 400;
    MinimumHeight = 300;
    MaximumHeight = 1000;
    RequestedWidth = 700;
    MinimumWidth = 700;
    MaximumWidth = 900;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts =
        './WeatherAPP/script.js';
    // StyleSheets =
    //     'style.css';
    // StartupScript = './WeatherAPP/script.js';
    // RecreateScript = 'recreateScript.js';
    // RefreshScript = 'refreshScript.js';
    // Path to the JavaScript and CSS files
    StartupScript = './WeatherAPP/weather.html';

    StyleSheets = './WeatherAPP/wea.css';

    // Notify when the control is ready to be used
    event ControlReady();
    event showcoordinate(address: JsonObject);
    // You can create procedures to communicate from AL to JavaScrip
    procedure getcity(address: text);
    procedure getlocation();
}