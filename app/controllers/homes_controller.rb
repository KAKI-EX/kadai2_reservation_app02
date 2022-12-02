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

  def back                                        #予約確認画面で戻るを押した場合
    @reservation = Reservation.new(params_permit)
    redirect_to new_homes_path(@reservation.post_id)
  end

  def edit_back                                   #予約編集画面で戻るを押した場合
    @reservation = params_permit
    redirect_to home_path(@reservation.user_id)
  end

  def new                                         #割り当て：部屋の予約ページ
    @post = Post.find(params[:id])
    @reservation = Reservation.new
    @user = User.find(@post.user_id)
  end

  def confirmation                                #割り当て:予約確認画面
    @reservation = Reservation.new(params_permit)
    if @reservation.invalid? || @reservation.check_in > @reservation.check_out
      redirect_to new_homes_path(@reservation.post_id),flash: { error: @reservation.errors.full_messages }
    else
      @stay_count = ((@reservation.check_out - @reservation.check_in).to_i/1.days).floor
      @total_fee = @reservation.room_fee * @reservation.peaple_count* @stay_count
    end
  end

  def create
    @reservation = Reservation.new(params_permit)
    if @reservation.save
      flash[:notice] = "お部屋の予約が完了しました"
      redirect_to confirmed_homes_path(@reservation)
    else
      redirect_to new_homes_path(@reservation.post_id)
    end
  end

  def confirmed                                    #割り当て:予約確定表示画面
    @reservation = Reservation.find(params[:id])
    @post = Post.find(@reservation.post_id)
  end

  def search_result                                #割り当て:部屋の検索結果一覧
    @posts_search = @q.result
    @posts_for_kaminari = @posts_search.page(params[:page])
  end

  def show                                         #割り当て:ユーザー予約一覧
    @user = User.find(params[:id])
    @reservations_relate = @user.reservations
  end

  def edit                                         #割り当て:ユーザー予約変更
    @reservation = Reservation.find(params[:id])
  end

  def edit_confirmation
    @reservation = Reservation.find(params[:id])
    @reservation.attributes = params_permit
    @stay_count = ((@reservation.check_out - @reservation.check_in).to_i/1.days).floor
    @total_fee = @reservation.room_fee * @reservation.peaple_count * @stay_count

    if @reservation.invalid?
      redirect_to edit_home_path(@reservation.post_id)
    end
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(params_permit)
      flash[:notice] = "予約の変更が完了しました"
      redirect_to confirmed_homes_path(@reservation)
    else
      redirect_to home_path(@reservation)
    end
  end

  def destroy
    def destroy
      @reservation = Reservation.find(params[:id])
      @reservation.destroy
      flash[:notice] = "予約を削除しました"
      redirect_to home_path(current_user.id)
    end
  end

  def search  #ransack用の記載
    @q = Post.ransack(params[:q])
  end

  private

  def params_permit
    params.require(:reservation).permit(
      :user_id,
      :post_id,
      :check_in,
      :check_out,
      :stay_count,
      :peaple_count,
      :room_fee,
      :total_fee
    )
  end
end
