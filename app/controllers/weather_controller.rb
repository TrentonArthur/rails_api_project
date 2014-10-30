    require 'open-uri'
    require 'json'




class WeatherController < ApplicationController

  def getLatLong(url)


  raw_data = open(url).read
  parsed = JSON.parse(raw_data)
  results = parsed['results'][0]['geometry']['location']
  return results

  end

  def getWeather(latlong)

  the_latitude = latlong[0]
  the_longitude = latlong[1]
  url = "https://api.forecast.io/forecast/5aa54c83e7ecb48281605efa3bc96e2b/#{the_latitude},#{the_longitude}"

  raw_data = open(url).read
  parsed = JSON.parse(raw_data)

  return parsed
  end

  def location
    @address = params["address"]
    url_safe_address = URI.encode(@address)

    url ="http://maps.googleapis.com/maps/api/geocode/json?address=$#{url_safe_address}"
    results = getLatLong(url)
    the_latitude = results['lat']
    the_longitude = results['lng']

    latlong = [the_latitude, the_longitude]

    parsed = getWeather(latlong)
    the_temperature = parsed['currently']['temperature']

    the_hour_outlook = parsed['hourly']['data'][0]['summary']
    the_day_outlook = parsed['daily']['data'][0]['summary']

 puts "The current temperature at #{@address} is #{the_temperature} degrees."
 puts "The outlook for the next hour is: #{the_hour_outlook}"
 puts "The outlook for the next day is: #{the_day_outlook}"

  end
end
