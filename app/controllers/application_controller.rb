class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_image_parameters, if: :devise_controller?
  before_action :set_search

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

end
