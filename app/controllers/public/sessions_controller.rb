# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    def user_state
      @user = User.find_by(email: params[:user][:email])
      if @user
        if @user.valid_password?(params[:user][:password]) && (@user.is_active == false)
          flash[:alert] = "退会済みです。再度ご登録をしてご利用ください"
          redirect_to new_user_registration_path
        else
        end
      else
      end
    end
end
