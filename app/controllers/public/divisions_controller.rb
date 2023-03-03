class Public::DivisionsController < ApplicationController
  # ログインしていない時、ログインページに遷移させる記述（devise）使用の時、利用可
  before_action :authenticate_staff!

  # ログインユーザのis_adminカラムがtrueかどうかでアクセス制限させる
  before_action :admin_staff

  def index
    @division = Division.new
    # IDごとに10件ずつ表示させる
    @divisions = Division.order(:id).page(params[:page]).per(10)
  end

  def create
    @division = Division.new(division_params)
    if @division.save
      flash[:notice] = "課名が追加されました。"
      # 登録に成功したら、課名一覧ページに飛ばす
      redirect_to public_divisions_path
    else
      # 課名一覧ページに課名追加画面を作成するため、同じく課名一覧ページに飛ばす
      render :index
    end
  end

  def edit
    @divisions = Division.find(params[:id])
  end

  def update
    @divisions = Division.find(params[:id])
    if @divisions.update!(division_params)
      # 課名情報の更新が成功したら課名一覧ページに遷移させる
      flash[:notice] = "課名情報が更新されました"
      redirect_to public_divisions_path
    else
      # 課名更新が失敗したら課名情報編集ページに戻す
      render :edit
    end
  end

  # 以下ストロングパラメータ(意図しない役職データの登録・更新を防ぐ)
  private
    def division_params
      params.require(:division).permit(:name)
    end

    def admin_staff
      # !:記述内容を反対にする。is_amin?はtrueを持ってくる記述だが、！がつくことでfalseを持ってくるようにできる
      if !current_staff.is_admin?
        # 社員一覧ページに遷移させる
        redirect_to public_staffs_path
      end
    end
end
