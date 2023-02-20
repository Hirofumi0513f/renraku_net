class Organization < ApplicationRecord
  has_many :departments
  has_many :divisions
  has_many :staffs
end
