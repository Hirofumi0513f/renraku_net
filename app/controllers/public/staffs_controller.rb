class Public::StaffsController < ApplicationController
  # ログインしていない時、ログインページに遷移させる記述（devise）使用の時、利用可
  before_action :authenticate_staff!

  require 'csv'

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
  end

  def search
    # search_nameの定義については、app/models/staff.rb内を参照ください
    # search_name_kanaの定義については、app/models/staff.rbを参照ください
    @staffs = Staff.search_name(params[:last_name], params[:first_name]).search_name_kana(params[:last_name_kana], params[:first_name_kana])
    # 以下の条件に記載がある際に、その情報を＠staffsに付け加える記述
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
    respond_to do |f|
      f.html
      f.csv do |csv|
        send_staffs_csv(@staffs)
      end
    end
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
    # Q.抽出した内容でcsvエクスポートしたい
    # 1.エクスポートしたい情報を全て実装する
    # 2.社員検索後の内容でエクスポートさせたい
    def send_staffs_csv(staffs)
    # CSV.generateとは、対象データを自動的にCSV形式に変換してくれるCSVライブラリの一種
    csv_data = CSV.generate do |csv|
      # %w()は、空白で区切って配列を返します
      column_names = %w(氏名 所属組織 役職 電話番号 メールアドレス)
      # csv << column_namesは表の列に入る名前を定義します。
      csv << column_names
      staffs.each do |staff|
        # column_valuesに代入するカラム値を定義します
        column_values = [
          # get_profile_image,←可能ならプロフィール画像も一緒にエクスポートしたい。
          # csvファイルがテキストデータである以上、画像は貼れない。
          staff.full_name,
          staff.department.name + '/' + staff.division.name,
          staff.position.name,
          staff.telephone_number,
          staff.email
        ]
        # csv << column_valueshは表の行に入る値を定義します。
        csv << column_values
      end
    end
    # csv出力のファイル名を定義します。
    send_data(csv_data, filename: "社員一覧.csv")
    end
end
