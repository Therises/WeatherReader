class Forecast < ApplicationRecord
  require 'open-uri'

  validates :city, presence: true

  def self.get_weather(prms={})

    geocode_location(prms[:city])
    api_requests
    data_arrays

    self.create(
      city: @city,
      max_temp: @max_temp,
      min_temp: @min_temp,
      precipitation: @precipitation,
      condition: @condition,
      user_id: prms[:user_id],
      )
  end

  def self.mail_update(forecast)
    city = forecast.city
    email = forecast.email
    new_forecast = Forecast.get_weather(city: city, user_id: forecast.user_id)
    new_forecast_attributes = new_forecast.attributes.slice('condition', 'max_temp', 'min_temp', 'precipitation')
    prev_forecast_attributes = forecast.attributes.slice('condition', 'max_temp', 'min_temp', 'precipitation')
    UpdateMailer.update_email(email, new_forecast).deliver unless new_forecast_attributes == prev_forecast_attributes
  end

  private

  class << self
    def geocode_location(prm)
      geocoded_data = Geocoder.search(prm).first
      @city = geocoded_data.address.split(',')[0] + ', ' + geocoded_data.country_code.upcase
      lat = geocoded_data.latitude.to_s
      lon = geocoded_data.longitude.to_s
      @coordinates = lat + ',' + lon
    end
   
    def api_requests
      apixu = "https://api.apixu.com/v1/forecast.json?key=6fa759cf6752403abaf193631182707&q=#{@city}&days=1"
      darksky = "https://api.darksky.net/forecast/ad8ae4788710996be9d7838666ad71ae/#{@coordinates}?exclude=currently,minutely,hourly,alerts,flags&units=si"
      weatherbit = "http://api.weatherbit.io/v2.0/forecast/daily?city=#{@city}&days=1&key=53a88ce7ac8048a487639d54962727b7"
     
      @apixu_data = JSON.parse(URI.parse(apixu).read)['forecast']['forecastday'][0]['day']
      @darksky_data = JSON.parse(URI.parse(darksky).read)['daily']['data'][1]
      @weatherbit_data = JSON.parse(URI.parse(weatherbit).read)['data'][0]
    end
   
    def data_arrays
      @max_temp = [
        @apixu_data['maxtemp_c'],
        @darksky_data['temperatureHigh'],
        @weatherbit_data['max_temp']
      ]
      @min_temp = [
        @apixu_data['mintemp_c'],
        @darksky_data['temperatureLow'],
        @weatherbit_data['min_temp']
      ]
      @precipitation = [
        'N/A',
        @darksky_data['precipProbability'],
        @weatherbit_data['pop']
      ]
      @condition = [
        @apixu_data['condition']['text'],
        @darksky_data['summary'],
        @weatherbit_data['weather']['description']
      ]
    end
  end
end