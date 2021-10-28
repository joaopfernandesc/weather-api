# frozen_string_literal

class WeatherController < ApplicationController
  def create
    weather = ::Weathers::CreateWeatherService.call(weather_params)

    render(json: weather, status: :created)
  end

  def show
    render(json: Weather.find(params[:id]), status: :ok)
  end

  def index
    weathers = WeathersRepository.filtered_by(Weather.includes(:temperatures), **filter_params)
    render(json: weathers, status: :ok)
  end

  private

  def weather_params
    params.permit(:date, :lat, :lon, :city, :state, temperatures: []).to_h
  end

  def filter_params
    params.permit(:date, :city, :sort).to_h.compact.symbolize_keys
  end
end