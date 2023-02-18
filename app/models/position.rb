class Position < ApplicationRecord
  belongs_to :staff
  has_many :position_names, dependent: :destroy
end
