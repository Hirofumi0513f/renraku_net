class Public::DepartmentsController < ApplicationController
  def index
    @department = Department.new
    @departments = Department.all
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:notice] = "部名が追加されました。"
      # 登録に成功したら、部署一覧ページに飛ばす
      redirect_to public_departments_path
    else
      # 部署一覧ページに部署追加画面を作成するため、同じく部署一覧ページに飛ばす
      render :index
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @departments = Department.find(params[:id])
    if @departments.update!(department_params)
      # 部署情報の更新が成功したら部署一覧ページに遷移させる
      flash[:notice] = "部署情報が更新されました"
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
end
