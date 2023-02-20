class Staff < ApplicationRecord
  belongs_to :organization
  belongs_to :position

  #社員の勤務形態のenum記述
  enum work_style: { work: 0, short_work: 1, leave_of_absence: 2, retirement:3}

  #staffモデルにimage（プロフィール画像)を持たせる記述
  has_one_attached :image

  #プロフィール画像の定義
  def get_profile_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

  # 社員氏名のフルネーム定義
  def full_name
    self.last_name + self.first_name
  end

  # 社員カナ氏名のフルネーム定義
  def full_name_kana
    self.last_name_kana + self.first_name_kana
  end

  # バリデーション設定
  # 名前（「姓」と「名」）のバリデーション/presenceヘルパーで入力必須にする
  validates :last_name, presence: true
  validates :first_name, presence: true

  # フリガナ（「セイ」と「メイ」）のバリデーション/presenceヘルパーで入力必須にする
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true

  # 電話番号のバリデーション/presenceヘルパーで入力必須にする
  validates :telephone_number, presence: true

  # メールアドレスのバリデーション/presenceヘルパーで入力必須にする
  validates :email, presence: true

  # 勤務形態のバリデーション/presenceヘルパーで入力必須にする
  validates :work_style, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
