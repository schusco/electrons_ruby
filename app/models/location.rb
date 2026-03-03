class Location < ApplicationRecord
  alias_attribute :field_name, :FieldName
  alias_attribute :city_state, :CityAndState
  scope :active, -> { where(Current: true) }
  # Ex:- scope :active, -> {where(:active => true)}
end
