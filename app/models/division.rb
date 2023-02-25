class Division < ApplicationRecord
  has_many :staffs

  # バリデーション設定
  # 課名のバリデーション/presenceヘルパーで入力必須にする
  validates :name, presence: true
end
