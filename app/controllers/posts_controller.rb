class PostsController < ApplicationController
  before_action :authenticate_user! #ログインユーザーのみ実行可能

  def index
    @posts_current_user = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    if Userprofile.exists?(user_id: current_user.id)
      @post = Post.new(params_permit)
      if @post.save
        flash[:notice] = "お部屋の登録が完了しました"
        redirect_to posts_path
      else
        render "new"
      end
    else
      flash[:alert] = "予期しないエラーが発生しました。プロフィールが登録されていない可能性があります"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @post = Post.find(params[:id])
    not_match_postid_currentuserid
  end

  def edit
    @post = Post.find(params[:id])
    not_match_postid_currentuserid
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params_permit)
      not_match_postid_currentuserid
      flash[:notice] = "#{@post.room_address_prefecture} #{@post.room_address_town_village}の編集が完了しました"
      redirect_to posts_path
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    not_match_postid_currentuserid
    @post.destroy
    flash[:notice] = "#{@post.room_address_prefecture} #{@post.room_address_town_village}のお部屋の情報を削除しました"
    redirect_to posts_path
  end


  private


  def params_permit
    params.require(:post).permit(
      :user_id,
      :room_name,
      :room_price,
      :room_info,
      :room_address_postcode,
      :room_address_prefecture,
      :room_address_town_village,
      :room_address_other,
      :room_photo
    )
  end

  def not_match_postid_currentuserid    #万が一current_user.idとPost.user_idが一致しない場合の対策
    unless @post.user_id == current_user.id
      flash[:alert] = "error reservation:予期しないエラーが発生しました"
      redirect_to posts_path
    end
  end

end
