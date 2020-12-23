class ApplicationController < ActionController::Base
  before_action :authenticate_customer!,except: [:top,:about,:index,:show]
  # before_action :authenticate_admin!,except: [:top]
  # before_action :admin_logged_in?

  # def authenticate_customer
  #   if @current_customer==nil
  #     redirect_to("/about")
  #   end
  # end
  def authenticate_admin
    if @current_user==nil
      # flash[:notice]="ログインが必要です"
      redirect_to new_admin_session_path
    end
  end
  # protected
  # def after_sign_in_path_for(resource)
  #   root_path
  # end

  # def after_sign_out_path_for(resource)
  #   root_path
  # end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  # end


end
