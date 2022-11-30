class HomesController < ApplicationController

  before_action :search

  def index
    @posts = Post.all
    # user_signed_in?: ログイン済みの場合はtrueを返す。
    # current_user: ログイン済みの場合はログインユーザーを返す。
    # ログイン済みの場合、ログインユーザーのidをログに書き込む。
    if user_signed_in?
      logger.debug current_user.id
    end
  end

  def back  #予約確認画面で戻るを押した場合
    @reservation = Reservation.new(params.require(:reservation).permit(
    :user_id,
    :post_id,
    :check_in,
    :check_out,
    :stay_count,
    :peaple_count,
    :room_fee,
    :total_fee
  ))
  redirect_to new_homes_path(@reservation.post_id)
  end

  def new  #部屋の予約ページ
    @post = Post.find(params[:id])
    @reservation = Reservation.new
    @user = User.find(@post.user_id)
  end

  def confirmation  #割り当て:予約確認画面
    @reservation = Reservation.new(params.require(:reservation).permit(:user_id,:post_id,
      :check_in,
      :check_out,
      :stay_count,
      :peaple_count,
      :room_fee,
      :total_fee
    ))
    @total_fee = @reservation.room_fee * @reservation.peaple_count
    @stay_count = ((@reservation.check_out - @reservation.check_in).to_i/1.days).floor

    if @reservation.invalid? #入力項目に空のものがあれば入力画面に遷移
      render new_homes_path
    end
  end

  def create
    @reservation = Reservation.new(params.require(:reservation).permit(
      :user_id,
      :post_id,
      :check_in,
      :check_out,
      :stay_count,
      :peaple_count,
      :room_fee
    ))
    if @reservation.save
      flash[:notice] = "お部屋の予約が完了しました"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def confirmed  #割り当て:予約確定表示画面 URL:home/user_reservation_list
  end

  def search_result  #割り当て:部屋の検索結果一覧
    @posts_search = @q.result
    @posts_for_kaminari = @posts_search.page(params[:page])
  end

  def show  #割り当て:ユーザー予約一覧
  end

  def edit  #割り当て:ユーザー予約変更
  end

  def update  #割り当て:ユーザー予約変更画面
  end

  def destroy
  end

  def search  #ransack用の記載
    @q = Post.ransack(params[:q])
  end

end
