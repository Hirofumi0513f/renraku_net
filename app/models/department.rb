class Department < ApplicationRecord
  belongs_to :staff
  belongs_to :department_name
  belongs_to :division_name
end
