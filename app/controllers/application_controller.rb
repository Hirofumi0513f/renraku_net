class ApplicationController < ActionController::Base
  # 登録作業の前にストロングパラメータに飛ばす記述
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  # devise版ストロングパラメータ。deviseのデフォルト（emailとpassword）登録意外を追加する際に記述が必要
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys: [:last_name, :first_name, :last_name_kana, :first_name_kana,
       :telephone_number, :email, :work_style,:department_id, :division_id, :position_id,  :password])
    end
end