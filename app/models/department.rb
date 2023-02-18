class Department < ApplicationRecord
  belongs_to :staff
  has_many :department_names, dependent: :destroy
  has_many :division_names, dependent: :destroy
end
