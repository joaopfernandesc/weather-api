# frozen_string_literal: true

class Weather < ApplicationRecord
  validates :date, format: { with: /\A\d{4}-\d{2}-\d{2}\Z/ }
  has_many :temperatures, dependent: :destroy

  def lon=(value)
    super(value.to_d * 10000)
  end

  def lat=(value)
    super(value.to_d * 10000)
  end

  def lat
    super / 10000.to_f
  end

  def lon
    super / 10000.to_f
  end

  def as_json(options = nil)
    super.merge('temperatures' => temperatures.pluck(:temperature).map(&:to_f))
  end
end
