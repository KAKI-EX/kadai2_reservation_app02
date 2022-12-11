class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_image_parameters, if: :devise_controller?
  before_action :set_search
  before_action :set_profile

  protected

  def after_sign_in_path_for(resource)
  homes_path(resource)
  end

  #Userstableにnameを追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_permitted_image_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end

  def set_search
    @q = Post.ransack(params[:q])
    @posts_search = @q.result
  end

  def set_profile
    if user_signed_in? && Userprofile.exists?(user_id: current_user.id)
      @userprofile_header = Userprofile.find(current_user.id)
    end
  end

end
