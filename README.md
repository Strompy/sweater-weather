
## Sweater Weather

Sweater Weather is an API built to provide weather, travel, and user data for a front end team to use in their views. Built as the final solo projecct for Module 3 at the Turing School of Software and Design. Data chosen based on frontend specifications and is returned in JSON API 1.0 format.

Sweater Weather is the final solo project for Turing School's Mod 3. The purpose for this app is to provide the front-end the data needed for the views. It consumes the [Google Map Geocoding](https://developers.google.com/maps/documentation), [OpenWeather](https://openweathermap.org/api/one-call-api) and [Unsplash](https://unsplash.com/documentation) APIs to return JSON API 1.0 compliant data to the front end. You can test the Sweater Weather's endpoints locally by following the instructions [here](#getting-started).

## Table of Contents

* [About](#about)
  * [Learning Goals](#learning-goals)
  * [Tech Stack](#tech-stack)
* [Getting Started](#getting-started)
  * [Installation](#installation)
  * [Testing](#testing)
* [Sweater Weather End Points](#sweater-weather-endpoints)

## About

Built to consume multiple APIs to retrieve data. Consumes the following APIs:
- [Mapquest Geocoding](https://developer.mapquest.com/documentation/geocoding-api/)
- [Mapquest Directions](https://developer.mapquest.com/documentation/directions-api/)
- [OpenWeather One Call](https://openweathermap.org/api/one-call-api)
- [Pixabay](https://pixabay.com/api/docs/)
- [Mountain Project Data](https://www.mountainproject.com/data)


### Learning Goals:

- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Research, select, and consume an API based on your needs as a

### Tech Stack:

- Ruby: 2.5.3
- Rails: 5.2.4
- PostgreSQL: 12

***Testing framework***
- RSpec
- Simplecov
- Shoulda-matchers

## Getting Started

To run locally, use the following steps:

### Installation

1. Clone the repo
```
git clone git@github.com:Strompy/sweater-weather.git
```
2. Install the Gems
```
bundle install
```
3. Setup your environment
```
rails db:create
rails db:migrate
```
4. Install Figaro
```
bundle exec figaro install
```
5. Grab your own key for each of the following APIs:
- [Mapquest](https://developer.mapquest.com/documentation/)
- [OpenWeather One Call](https://openweathermap.org/api/one-call-api)
- [Pixabay](https://pixabay.com/api/docs/)
- [Mountain Project Data](https://www.mountainproject.com/data)

Store your keys in the `application.yml` created by figaro, found inside the `app/config` directory.

```
MAPQUEST_CONSUMER_KEY: <YOUR MAPQUEST API KEY>
OPENWEATHER_API_KEY: <YOUR OPEN WEATHER API KEY>
PIXABAY_API_KEY: <YOUR PIXABAY API KEY>
MOUNTAIN_PROJECT_KEY: <YOUR MOUNTAIN PROJECT API KEY>
```

You will also need to add the following base URLs to the `application.yml`.

```
# API URLS
GEOCODE_SERVICE_URL: http://www.mapquestapi.com/geocoding/v1
WEATHER_SERVICE_URL: https://api.openweathermap.org/data/2.5/onecall
IMAGE_SERVICE_URL: https://pixabay.com/api/
ROUTES_SERVICE_URL: https://www.mountainproject.com/data
DIRECTIONS_SERVICE_URL: https://www.mapquestapi.com/directions/v2
```

All the variables stored in this file can be accessed like so:

```
ENV['<VARIABLE_NAME>']
```

### Testing

To run the test suite from the root directory simply run rspec:

```
$ bundle exec rspec
```

Or run individual tests by including the file path at the end of the above command.

## Sweater Weather Endpoints

* [Get weather forecast](#get-a-weather-forecast-for-a-specific-location)
* [Get an image](#get-an-image-for-a-specific-location)
* [Register a new user](#register-a-new-user)
* [Login a user](#log-in-an-existing-user)
* [Road trip planner](#road-trip-planner-for-registered-users)


#### Get a weather forecast for a specific location:

```
GET /api/v1/forecast?location=<location>
```

Example request:

```
GET /api/v1/forecast?location=denver,co
```

Example response:

```
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "location": "denver,co",
      "date_time_info": {
        "timezone": "America/Denver",
        "offset": -21600
      },
      "current": {
        "date_time": 1600828298,
        "temp": 68.88,
        "description": "broken clouds",
        "high": 86.74,
        "low": 66.94,
        "sunrise": 1600778883,
        "sunset": 1600822611,
        "feels_like": 60.8,
        "humidity": 30,
        "visibility_in_miles": 1.89,
        "uv_index": 6.48
      },
      "hourly": [
        {
          "date_time": 1600826400,
          "temp": 68.88,
          "description": "broken clouds"
        },
        {
          "date_time": 1600830000,
          "temp": 71.33,
          "description": "overcast clouds"
        },
        {
          "date_time": 1600833600,
          "temp": 70.75,
          "description": "overcast clouds"
        },
        {
          "date_time": 1600837200,
          "temp": 70.56,
          "description": "overcast clouds"
        },
        {
          "date_time": 1600840800,
          "temp": 70.25,
          "description": "overcast clouds"
        },
        {
          "date_time": 1600844400,
          "temp": 69.67,
          "description": "overcast clouds"
        },
        {
          "date_time": 1600848000,
          "temp": 68.94,
          "description": "overcast clouds"
        },
        {
          "date_time": 1600851600,
          "temp": 67.95,
          "description": "broken clouds"
        }
      ],
      "daily": [
        {
          "date_time": 1600797600,
          "high_temp": 86.74,
          "low_temp": 66.94,
          "total_precipitation": 0,
          "description": "light rain"
        },
        {
          "date_time": 1600884000,
          "high_temp": 84.65,
          "low_temp": 67.03,
          "total_precipitation": 0,
          "description": "light rain"
        },
        {
          "date_time": 1600970400,
          "high_temp": 88.25,
          "low_temp": 66.27,
          "total_precipitation": 0,
          "description": "clear sky"
        },
        {
          "date_time": 1601056800,
          "high_temp": 90.43,
          "low_temp": 69.04,
          "total_precipitation": 0,
          "description": "clear sky"
        },
        {
          "date_time": 1601143200,
          "high_temp": 83.25,
          "low_temp": 65.55,
          "total_precipitation": 0,
          "description": "overcast clouds"
        }
      ]
    }
  }
}
```

#### Get an image for a specific location:

```
GET /api/v1/backgrouds?location=<location>
```

Example request:

```
GET /api/v1/backgrounds?location=denver,co
```

Example response:

```
{
  "data": {
    "id": null,
    "type": "image",
    "attributes": {
      "location": "denver,co",
      "image_url": "https://pixabay.com/get/54e6d4444f50a814f6da8c7dda7936761637d6ec51546c48732f7bdc9545c35db1_1280.jpg",
      "credit": {
        "source": "pixabay.com",
        "author": "quinntheislander",
        "logo": "https://pixabay.com/static/img/logo_square.png"
      }
    }
  }
}
```

#### Register a new user:

```
POST /api/v1/users
```

Request body:
```
{
  "email": "user@example.com",
  "password": "password"
  "password_confirmation": "password"
}
```

Example request:

```
POST /api/v1/users

{
  "email": "user@example.com",
  "password": "password"
  "password_confirmation": "password"
}
```

Example response:

```
response status: 201
response body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "user@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

#### Log in an existing user:

```
POST /api/v1/sessions
```
Request body:
```
{
  "email": "user@example.com",
  "password": "password"
  "password_confirmation": "password"
}
```

Example request:

```
POST /api/v1/sessions

{
  "email": "user@example.com",
  "password": "password"
}
```

Example response:

```
response status: 200
response body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "user@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

#### Road trip planner for registered users:

```
POST /api/v1/road_trip
```
Request body:
```
{
  "origin": "<origin_name>",
  "destination": "<destination_name>",
  "api_key": "<user_api_key>"
}
```

Example request:

```
POST /api/v1/road_trip

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

Example response:

```
response status: 200
response body:

{
 "data":
 {
   "id":null,
   "type":"road_trip",
   "attributes":
   {
     "origin":"Denver,CO",
     "destination":"Pueblo,co",
     "travel_time":"01:43",
     "arrival_forecast":
     {
       "temp":80.04,
       "description":"clear sky"
     }
   }
 }
}
```
