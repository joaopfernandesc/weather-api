# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Weathers::CreateWeatherService) do
  let(:params) do
    {
      date: '1985-01-11',
      lat: 36.1189,
      lon: -86.6892,
      city: 'Nashville',
      state: 'Tennessee',
      temperatures: [
        17.3, 16.8, 16.4
      ]
    }
  end

  it 'creates a Message' do
    expect { described_class.call(params) }.to(change { Weather.count }.by(1))
  end

  it 'creates Temperature' do
    expect { described_class.call(params) }.to(change { Temperature.count }.by(3))
  end

  it 'associates Temperature to Weather' do
    weather = described_class.call(params)

    expect(weather.temperatures.count).to(eq(3))
  end
end
