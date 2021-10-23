# frozen_string_literal

class WeatherController < ApplicationController
  def create
    weather = ::Weathers::CreateWeatherService.call(weather_params)

    render(json: weather, status: :created)
  end

  private

  def weather_params
    params.permit(:date, :lat, :lon, :city, :state, temperatures: []).to_h
  end
end