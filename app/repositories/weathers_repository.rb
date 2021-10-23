# frozen_string_literal: true

class WeathersRepository
  class << self
    def filtered_by(weathers, sort: nil, date: nil, city: nil)
      weathers = filter_by_date(weathers, date) if date
      weathers = filter_by_cities(weathers, city) if city
      weathers = order(weathers, sort) if sort

      weathers
    end

    def filter_by_date(weathers, date)
      weathers = weathers.where(date: date)
    end

    def filter_by_cities(weathers, city)
      cities = city.downcase.split(',')
      weathers.where('lower(city) IN (?)', cities)
    end

    def order(weathers, sort)
      weathers.order(**date_order(sort), id: :asc)
    end

    private

    def date_order(sort_expression)
      sorting_order = sort_expression.starts_with?('-') ? :desc : :asc
      { date: sorting_order }
    end
  end
end