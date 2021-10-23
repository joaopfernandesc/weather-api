# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(WeathersRepository) do
  before(:each) do
    Weather.create(
      [
        { lat: 0, lon: 0, date: '2021-10-10', city: 'Campinas', state: 'São Paulo' },
        { lat: 0, lon: 0, date: '2021-10-11', city: 'Nashville', state: 'Tennessee' }
      ]
    )
  end

  describe '#filter_by_date' do
    it 'filters by date' do
      filtering_date = '2021-10-10'

      weathers = described_class.filter_by_date(Weather.all, filtering_date)

      expect(weathers.count).to(eq(1))
      expect(weathers.first.date).to(eq(filtering_date))
    end
  end

  describe '#filter_by_cities' do
    it 'filters by city' do
      weathers = described_class.filter_by_cities(Weather.all, 'cAmpiNas')

      expect(weathers.count).to(eq(1))
      expect(weathers.first.city).to(eq('Campinas'))
    end
  end

  describe '#order' do
    it 'orders by date ascending' do
      expected_date_order = ['2021-10-10', '2021-10-11']

      weathers = described_class.order(Weather.all, 'date')

      expect(weathers.pluck(:date)).to(eq(expected_date_order))
    end

    it 'orders by date ascending' do
      expected_date_order = ['2021-10-11', '2021-10-10']

      weathers = described_class.order(Weather.all, '-date')

      expect(weathers.pluck(:date)).to(eq(expected_date_order))
    end
  end

  describe '#filtered_by' do
    before(:each) do
      allow(described_class).to(receive(:filter_by_cities))
      allow(described_class).to(receive(:filter_by_date))
      allow(described_class).to(receive(:order))
    end

    it 'filters by city' do
      city = 'campinas'
      weathers = described_class.filtered_by(Weather.all, city: city)

      expect(described_class).to(have_received(:filter_by_cities).with(ActiveRecord::Relation, city))
      expect(described_class).not_to(have_received(:filter_by_date))
      expect(described_class).not_to(have_received(:order))
    end

    it 'filters by date' do
      date = '2021-10-10'
      weathers = described_class.filtered_by(Weather.all, date: date)

      expect(described_class).not_to(have_received(:filter_by_cities))
      expect(described_class).to(have_received(:filter_by_date).with(ActiveRecord::Relation, date))
      expect(described_class).not_to(have_received(:order))
    end

    it 'sorts' do
      sort = '-date'
      weathers = described_class.filtered_by(Weather.all, sort: sort)

      expect(described_class).not_to(have_received(:filter_by_cities))
      expect(described_class).not_to(have_received(:filter_by_date))
      expect(described_class).to(have_received(:order).with(ActiveRecord::Relation, sort))
    end
  end
end
