class Position < ApplicationRecord
  belongs_to :staff
  has_many :posirion_names
end
