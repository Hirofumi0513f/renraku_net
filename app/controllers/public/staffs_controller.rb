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
  end

  def edit
    @staffs =Staff.find(params[:id])
    # 社員ID＝ログイン社員IDまたは、ログイン社員のis_adminがtrueの時編集を許可させる条件分岐
    if @staffs.id == current_staff.id || current_staff.is_admin?
      render :edit
    else
      # 社員一覧画面に飛ばす
      redirect_to public_staffs_path
    end
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

  def search_form
    @staffs = Staff.all

    # 検索オブジェクトの作成
    # @p = Staff.ransack(params[:q])
    # # 検索結果を@resultsに挿入/(distinct: true)→あいまい検索結果の表示を正確にする記述？
    # @results = @p.result(distinct: true)
    # 検索ページで条件を入れて検索後、検索条件に合う情報をindexページに表示させる
  end

  def search
    @staffs = Staff.search_name(params[:last_name], params[:first_name])

    if params[:department_id].present?
      @staffs = @staffs.where(department_id: params[:department_id])
    end

    if params[:division_id].present?
      @staffs = @staffs.where(division_id: params[:division_id])
    end

    if params[:position_id].present?
      @staffs = @staffs.where(position_id: params[:position_id])
    end
    # "%#{@full_name}%"：部分一致条件
    # "#{@full_name}":完全一致条件

    @staffs = @staffs.order(:id).page(params[:page]).per(10)

  end

  # 以下ストロングパラメータ（意図しない社員データの登録・更新を防ぐ）,検索は関係ない
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
