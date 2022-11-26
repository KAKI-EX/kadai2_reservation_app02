class PostsController < ApplicationController
  before_action :authenticate_user! #ログインユーザーのみ実行可能

  def index

    @posts_current_user = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(
      :user_id,
      :room_name,
      :room_price,
      :room_info,
      :room_address_postcode,
      :room_address_prefecture,
      :room_address_town_village,
      :room_address_other,
      :room_photo
    ))
    if @post.save
      flash[:notice] = "お部屋の登録が完了しました"
      redirect_to posts_path
    else
      render "new",status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(
      :user_id,
      :room_name,
      :room_price,
      :room_info,
      :room_address_postcode,
      :room_address_prefecture,
      :room_address_town_village,
      :room_address_other,
      :room_photo
    ))
    flash[:notice] = "#{@post.room_address_prefecture} #{@post.room_address_town_village}の編集が完了しました"
    redirect_to posts_path
    else
      render "edit",status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "#{@post.room_address_prefecture} #{@post.room_address_town_village}のお部屋の情報を削除しました"
    redirect_to posts_path
  end

end
