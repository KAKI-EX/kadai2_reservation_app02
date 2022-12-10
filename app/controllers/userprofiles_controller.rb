class UserprofilesController < ApplicationController

  def new
    @userprofile = Userprofile.new
  end

  def create
    @userprofile = Userprofile.new(params_permit)
    if @userprofile.save
      flash[:notice] = "プロフィールの登録が完了しました"
      redirect_to userprofile_path
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @userprofile = @user.userprofile
  end

  def edit
    @user = User.find(params[:id])
    @userprofile = @user.userprofile
  end

  def update
    @userprofile = Userprofile.find(params[:id])
    if @userprofile.update(params_permit)
      not_match_userprofileid_currentuserid
      flash[:notice] = "プロフィールの編集が完了しました"
      redirect_to userprofile_path
    else
      render "edit"
    end

  end

  private

  def params_permit
    params.require(:userprofile).permit(
      :user_id,
      :self_introduce,
      :user_name,
      :user_avatar
    )
  end

  def not_match_userprofileid_currentuserid    #万が一current_user.idとPost.user_idが一致しない場合の対策
    unless @userprofile.user_id == current_user.id
      flash[:alert] = "error userprofile:予期しないエラーが発生しました"
      redirect_to userprofile_path
    end
  end

end
