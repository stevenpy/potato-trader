class PotatoPrice < ApplicationRecord
  validates :time, presence: true
  validates :value, presence: true, numericality: {greater_than: 0}

  scope :for_date, ->(date) {
    where("time BETWEEN ? AND ?", date.beginning_of_day, date.end_of_day)
      .order(:time)
  }
end
