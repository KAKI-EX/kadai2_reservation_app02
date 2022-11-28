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

  def new
    @post = Post.all
    @reservation = Reservation.new
  end

  def create #割り当て:部屋の予約ページ
  end

  def confirmation  #割り当て:予約確認画面 URL:home/confirmation
  end

  def confirmed  #割り当て:予約確定表示画面 URL:home/user_reservation_list
  end

  def user_reservation_list  #割り当て:ユーザー予約一覧
  end

  def search_result  #割り当て:部屋の検索結果一覧
    @posts_search = @q.result
    @posts_for_kaminari = @posts_search.page(params[:page]).per(10)
  end

  def show
  end

  def edit  #割り当て:ユーザー予約変更
  end

  def update  #割り当て:ユーザー予約変更画面
  end


  def destroy
  end

  def search
    @q = Post.ransack(params[:q])

  end


end
