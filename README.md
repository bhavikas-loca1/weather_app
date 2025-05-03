# VVeatherly App
<p>
VVeatherly is a simple, minimilistic and aesthetic cross-platform Flutter weather application that provides real-time weather information, UV index, and a chatbot interface for weather queries. The app uses the OpenWeatherMap One Call 3.0 API and supports both light and dark themes. </p>
<p> This app was originally a figma idea that was then brought to life using flutter. 
</p>

## demo version
<video controls src="demo.mp4" title="Title"></video>
The actual screenshots of the android version of the app are as follows: 

![actual android icon](actual_icon.jpg)
![first splash screen](splash_screen_withaudio.jpg)
![second splash screen](main_screen.jpg)
![default light mode](light_mode.jpg)
![dark mode](dark_mode.jpg)
![search bar demonstration](search_bar.jpg)
![chatbot_screen](chatbot_screen.jpg)
![uv index page](uv_index.jpg)


---

## Features
- Provides information on the weather conditions, temperature and hourly forecasts for the current location (by default) and for any other location across the globe
- Animated splash screen with audio
- Lottie json packages for weather icons 
- Allows switching between the dark and light mode themes 
- Allows one to ask for weather information about any city using a simple chatbot interface
---

## Getting Started
NOTE: Set up the flutter environment using the official flutter documentation for installation 
<p> https://docs.flutter.dev/get-started/install </p>

### 1. Clone the repository
<p> git clone https://github.com/bhavikas-loca1/weather_app.git </p>
<p> cd weather_app </p>

### 2. install dependencies 
flutter pub get

### 3. create an api_KEY folder in your assets 
In it create a secret_key.json file that contains your api key in the following format
<p>
{
    "OPENWEATHER_API_KEY": "ENTER_YOUR_API_KEY_HERE"
  }
</p>
<p> NOTE: You have to subscribe to the openweatherapp one-call api 3.0 inorder to enable the access to this api. This api will provide you with current weather, hourly forecasts and uv indexEven though this api requires you to give out your card details, worry not because upto 999 calls are free per day. Once you have received the confirmation mail, you can use your default api key from openweatherapi to access the 3.0 endpoint. </p>

### 4. run the application
Flutter run </n>
NOTE: Check for your sdk dependencies and permission issues (i.e., check ios/runner and android/app/src) before running the app

## Project Structure 
- assets directory for animations, api_KEY (Secret), audio, fonts(only for crimson pro, rest using direct google fonts embedding), icons (the actual files for ios and android app icons are defined in android/app/src/res/midmaps and ios/Runner/Assets.xcassets) and images
- lib directory (contains the actual code for the app)
    - lib/models/weather_model.dart : contains the class in which the data model shall be represented 
    - lib/services/weather_services.dart : contains the API services for fetching all the relevant weather data
    - lib/themes/themes.dart : contains the themes (such as color themes and crushed being the default font) for the application
    - lib/main.dart : it is the main file that is called. It contains the materialApp build and defines other aspects of the project, as well as defines the homescreen (in our case, it is the first splashscreen as defined in lib/modules/splash_module/splash_screen.dart)
    - lib/module/splash_module/splash_screen.dart : it contains a simple animation that makes the images of different clouds (ms paint drawn :3) go from left to right and vica versa over a plain colored background with low opacity and ambient background sound. After the animation is over, it transitions to lib/module/splash_module/new_splash_screen.dart
    - lib/module/splash_module/new_splash_screen.dart : it is a static screen with clouds and the application name or info. After three seconds, it transitions to lib/module/temperature/temperature.dart
    - lib/module/temperature/temperature.dart : this is the main light themed screen containing the following features -
        - main condition lottie json animation
        - city name (Current by default) and temperature 
        - hourly forecasts
        - button that leads to lib/modules/uv_index_module/uv_index_screen.dart 
        - button that leads to lib/chatbot/chatbot_screen.dart
        - button that helps to switch over to the dark theme
        - search bar for searching other cities up 
    - lib/module/temperature/temperature_dark.dart : this is the dark themed screen containing the following features -
        - main condition lottie json animation
        - city name (Current by default) and temperature 
        - hourly forecasts
        - button that leads to lib/modules/uv_index_module/uv_index_screen.dart 
        - button that leads to lib/chatbot/chatbot_screen.dart
        - button that helps to switch over to the light theme
        - search bar for searching other cities up 
    - lib/modules/uv_index_module/uv_index_screen.dart : it displays three main things - the current uv index in double, the bar indicating the uv index by color and a green/yellow sun to tell when is it safe to go out without sunscreen and protection/when not
    - lib/chatbot/chatbot_screen.dart : a simple weather chatbot assistant for answering basic questions 

## Dependencies 
- http: For API requests to OpenWeatherMap
- geocoding: For converting city names to coordinates
- geolocator: For accessing device location
- lottie: For weather animations
- provider: For state management

## Contributing
- Fork the repository
- Create your feature branch (git checkout -b feature/amazing-feature)
- Commit your changes (git commit -m 'Add some amazing feature')
- Push to the branch (git push origin feature/amazing-feature)
- Open a Pull Request

## Licensing
This project is licensed under the MIT License - see the LICENSE file for details.

## acknowledgements
- Weather data provided by OpenWeatherMap
- UI design inspiration from Figma (mail : bhavika.singh11@gmail.com for access)
- Icons and animations from various open-source libraries such as lottie 
- pub.dev community for their plugins 
- my college for pushing me to finish this project for my software engineering and project management class