class PositionName < ApplicationRecord
  # , optional: true→外部キーのnilを許可するコマンド
  belongs_to :position, optional: true
end
