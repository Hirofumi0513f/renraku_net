class DivisionName < ApplicationRecord
  # , optional: true→外部キーのnilを許可するコマンド
  belongs_to :department, optional: true
end
