class Public::DepartmentsController < ApplicationController
  # ログインしていない時、ログインページに遷移させる記述（devise）使用の時、利用可
  before_action :authenticate_staff!

  # ログインユーザのis_adminカラムがtrueかどうかでアクセス制限させる
  before_action :admin_staff

  def index
    @department = Department.new
    # IDごとに9件ずつ表示させる
    @departments = Department.order(:id).page(params[:page]).per(9)
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:notice] = "部名が追加されました"
      # 登録に成功したら、部署一覧ページに飛ばす
      redirect_to public_departments_path
    else
      flash[:notice] = "部名の追加に失敗しました"
      @departments = Department.order(:id).page(params[:page]).per(9)
      # 部署一覧ページに部署追加画面を作成するため、同じく部署一覧ページに飛ばす
      render :index
    end
  end

  def edit
    @departments = Department.find(params[:id])
  end

  def update
    @departments = Department.find(params[:id])
    if @departments.update(department_params)
      # 部署情報の更新が成功したら部署一覧ページに遷移させる
      flash[:notice] = "部名が更新されました"
      redirect_to public_departments_path
    else
      # 部署更新が失敗したら部署情報編集ページに戻す
      render :edit
    end
  end

  # 以下ストロングパラメータ(意図しない役職データの登録・更新を防ぐ)
  private
    def department_params
      params.require(:department).permit(:name)
    end

    def admin_staff
      # !:記述内容を反対にする。is_amin?はtrueを持ってくる記述だが、！がつくことでfalseを持ってくるようにできる
      if !current_staff.is_admin?
        # 社員一覧ページに遷移させる
        redirect_to public_staffs_path
      end
    end
end
