class Department < ApplicationRecord
  belongs_to :staff
  has_many :department_names
  has_many :division_names
end
