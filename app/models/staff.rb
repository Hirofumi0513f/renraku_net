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

  # staffモデルに、パスワード検証させる
  # 対象モデルに「password_digest」カラムを用意する
  # Gemfileの「gem 'bcrypt', '~> 3.1.7'」記述のコメントアウトを外す。ターミナル上で「bundle install」を実行
  # has_secure_password:パスワードを暗号化して保存するメソッド



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
