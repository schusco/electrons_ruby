class Event < ApplicationRecord
  validates :event, presence: true
  validates :date, presence: true
  scope :current, -> { where("date >= ?", Date.new(Time.current.year, 1, 1)).order(:date) }
  # Ex:- scope :active, -> {where(:active => true)}
end
