class Position < ApplicationRecord
  has_many :staffs

  # バリデーション設定
  # 役職名のバリデーション/presenceヘルパーで入力必須にする
  validates :name, presence: true
end
