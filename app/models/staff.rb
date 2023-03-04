class Staff < ApplicationRecord
  belongs_to :department, dependent: :destroy
  belongs_to :division, dependent: :destroy
  belongs_to :position, dependent: :destroy

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

  def self.search_name(last_name, first_name)
    if last_name.present? && first_name.present?
      Staff.where('last_name LIKE ?', "%#{last_name}%").or(Staff.where('first_name LIKE ?', "%#{first_name}%"))
    elsif last_name.present?
      Staff.where('last_name LIKE ?', "%#{last_name}%")
    elsif first_name.present?
      Staff.where('first_name LIKE ?', "%#{first_name}%")
    else
      Staff.all
    end
  end

  def self.search_name_kana(last_name_kana, first_name_kana)
    if last_name_kana.present? && first_name_kana.present?
      Staff.where('last_name_kana LIKE ?', "%#{last_name_kana}%").or(Staff.where('first_name_kana LIKE ?', "%#{first_name_kana}%"))
    elsif last_name_kana.present?
      Staff.where('last_name_kana LIKE ?', "%#{last_name_kana}%")
    elsif first_name_kana.present?
      Staff.where('first_name_kana LIKE ?', "%#{first_name_kana}%")
    else
      Staff.all
    end
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

  # パスワードのバリデーション/presenceヘルパーで入力必須にする/length: { minimum: 6 }6文字以上のパスワードか検証する。/on: create→登録の時のみバリデーションを有効にする
  #validates :password, presence: true, length: { minimum: 6 }, on: :create

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
