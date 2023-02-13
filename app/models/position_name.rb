class PositionName < ApplicationRecord
  belongs_to :position, optional: true
end
