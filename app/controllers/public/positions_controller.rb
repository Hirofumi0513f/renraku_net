class Public::PositionsController < ApplicationController
  def index
    @position = Position.new
    # IDごとに10件ずつ表示させる
    @positions = Position.order(:id).page(params[:page]).per(10)
  end

  def create
    @position = Position.new(position_params)
    if @position.save
      flash[:notice] = "役職が追加されました。"
      # 登録に成功したら、役職一覧ページに飛ばす
      redirect_to public_positions_path
    else
      # 役職一覧ページに役職追加画面を作成するため、同じく役職一覧ページに飛ばす
      render :index
    end
  end

  def edit
    @positions = Position.find(params[:id])
  end

  def update
    @positions = Position.find(params[:id])
    if @positions.update!(position_params)
      # 役職情報の更新が成功したら役職一覧ページに遷移させる
      flash[:notice] = "役職情報が更新されました"
      redirect_to public_positions_path
    else
      # 役職更新が失敗したら役職情報編集ページに戻す
      render :edit
    end
  end

  # 以下ストロングパラメータ(意図しない役職データの登録・更新を防ぐ)
  private
    def position_params
      params.require(:position).permit(:name)
    end
end
