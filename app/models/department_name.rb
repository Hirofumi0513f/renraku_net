class DepartmentName < ApplicationRecord
  belongs_to :department, optional: true
end
