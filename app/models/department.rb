class Department < ApplicationRecord
  has_many :staffs
  
  # バリデーション設定
  # 部名のバリデーション/presenceヘルパーで入力必須にする
  validates :name, presence: true  
end
