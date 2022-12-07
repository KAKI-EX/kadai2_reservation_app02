class HomesController < ApplicationController
  before_action :search
  before_action :authenticate_user!, except: [:index, :new, :search_result] #未ログインユーザーは案件の閲覧のみ



  def index
    @posts = Post.all
    # ログイン済みの場合、ログインユーザーのidをログに書き込む。
    if user_signed_in?
      logger.debug current_user.id
    end
  end

  def search_result                                #割り当て:部屋の検索結果一覧
    @posts_search = @q.result
    @posts_for_kaminari = @posts_search.page(params[:page])
  end

  def search  #ransack用の記載
    @q = Post.ransack(params[:q])
  end

  def new #割り当て：部屋の予約ページ
    @post = Post.find(params[:id])
    @reservation = Reservation.new
    @user = User.find(@post.user_id)
  end

  def confirmation #割り当て:予約確認画面
    begin #予約確認画面でリロードするとエラーが発生するためエラー処理を実装
      @reservation = Reservation.new(params_permit)
      if @reservation.invalid? || @reservation.check_in > @reservation.check_out
        redirect_to new_homes_path(@reservation.post_id),flash: { error: @reservation.errors.full_messages }
      else
        @stay_count = ((@reservation.check_out - @reservation.check_in).to_i/1.days).floor
        @total_fee = @reservation.room_fee * @reservation.people_count* @stay_count
      end
        not_match_reservationuserid_currentuserid
    end
    rescue
      flash[:alert] = "予期しないエラーが発生しました。ブラウザの戻るボタンを押して入力内容を戻せます"
      redirect_back(fallback_location: root_path)
  end


  def create
    @reservation = Reservation.new(params_permit)
    not_match_reservationuserid_currentuserid
    if @reservation.save
      flash[:notice] = "お部屋の予約が完了しました"
      redirect_to confirmed_homes_path(@reservation)
    else
      redirect_to new_homes_path(@reservation.post_id)
    end
  end

  def confirmed                                    #割り当て:予約済み情報表示画面
    @reservation = Reservation.find(params[:id])
    @post = Post.find(@reservation.post_id)
    not_match_reservationuserid_currentuserid
  end

  def show                                         #割り当て:ユーザー予約一覧
    @user = User.find(params[:id])
    @reservations_relate = @user.reservations
    not_match_userid_current_userid
  end

  def edit                                         #割り当て:ユーザー予約変更
    @reservation = Reservation.find(params[:id])
    not_match_reservationuserid_currentuserid
  end





  def edit_confirmation
    begin #編集確認画面でリロードするとエラーが発生するためエラー処理を実装
      @reservation = Reservation.find(params[:id])
      not_match_reservationuserid_currentuserid
      @reservation.attributes = params_permit
      if @reservation.invalid? || @reservation.check_in > @reservation.check_out
        redirect_to edit_home_path(@reservation.id),flash: { error: @reservation.errors.full_messages }
      else
        @stay_count = ((@reservation.check_out - @reservation.check_in).to_i/1.days).floor
        @total_fee = @reservation.room_fee * @reservation.people_count * @stay_count
      end
    rescue
      flash[:alert] = "予期しないエラーが発生しました。予約確認画面で再読み込みされた可能性があります。"
      redirect_back(fallback_location: root_path)
    end
  end







  def update
    @reservation = Reservation.find(params[:id])
    not_match_reservationuserid_currentuserid
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
      not_match_reservationuserid_currentuserid
      @reservation.destroy
      flash[:notice] = "予約を削除しました"
      redirect_to home_path(current_user.id)
    end
  end


  private


  def params_permit
    params.require(:reservation).permit(
      :user_id,
      :post_id,
      :check_in,
      :check_out,
      :stay_count,
      :people_count,
      :room_fee,
      :total_fee
    )
  end

  def not_match_reservationuserid_currentuserid #万が一current_user.idとReservation.user_idが一致しない場合の対策
    unless @reservation.user_id == current_user.id
      flash[:alert] = "error:#{action_name}予期しないエラーが発生しました"
      redirect_to root_path
    end
  end

  def not_match_userid_current_userid #万が一current_user.idとUser.idが一致しない場合の対策
    unless @user.id == current_user.id
      flash[:alert] = "error:#{action_name}予期しないエラーが発生しました"
      redirect_to root_path
    end
  end
end
