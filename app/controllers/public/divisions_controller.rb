class Public::DivisionsController < ApplicationController
  def index
    @divisions = Division.all
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
    @division = Division.find(params[:id])
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
end
