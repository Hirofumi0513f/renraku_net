class Public::StaffsController < ApplicationController
  # ログインしていない時、ログインページに遷移させる記述（devise）使用の時、利用可
  before_action :authenticate_staff!

  def index
    # 社員IDごとに10件ずつ表示させる
    @staffs = Staff.order(:id).page(params[:page]).per(10)
  end

  def show
    # 社員IDに紐づく詳細情報を表示させる
    @staffs =Staff.find(params[:id])

    @staff = current_staff
  end

  def edit
    @staffs =Staff.find(params[:id])
  end

  def update
    @staffs = Staff.find(params[:id])
    if @staffs.update!(staff_params)
      flash[:notice] ="社員情報が更新されました"
      # 社員情報の詳細ページに飛ばす
      redirect_to public_staff_path(@staffs.id)
    else
      render :edit
    end
  end

  def search
  end

  # 以下ストロングパラメータ（意図しない社員データの登録・更新を防ぐ）
  private
    def staff_params
      params.require(:staff).permit(
        :last_name,
        :first_name,
        :last_name_kana,
        :first_name_kana,
        :telephone_number,
        :email,
        :work_style,
        :is_admin,
        :image,
        :department_id,
        :division_id,
        :position_id,
        :password
        )
    end
end
