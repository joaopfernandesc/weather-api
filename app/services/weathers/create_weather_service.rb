# frozen_string_literal: true

module Weathers
  class CreateWeatherService
    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @weather_params = params.except(:temperatures)
      @temperatures = params.fetch(:temperatures)
    end

    def call
      ActiveRecord::Base.transaction do
        weather = Weather.create!(weather_params)
        weather.temperatures.create!(temperature_params)

        weather
      end
    end

    private

    attr_reader  :weather_params, :temperatures

    def temperature_params
      temperatures.map { |temperature| { temperature: temperature } }
    end
  end
end