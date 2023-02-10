class Staff < ApplicationRecord
  has_many :departments
  has_many :positions
  has_many :admins
  
  #社員の勤務形態のenum記述
  enum work_style: { retirement: 0, work: 1, short_work: 2, leave_of_absence: 3 }
  
  #staffモデルにimage（プロフィール画像)を持たせる記述
  has_one_attached :image
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
