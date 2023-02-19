class PositionName < ApplicationRecord
  # , optional: true→外部キーのnilを許可するコマンド
  has_many :positions
  # , through: :departments:departmentテーブルを経由して、紐づいているstaffsを取得できる
  has_many :staffs, through: :positions
end
