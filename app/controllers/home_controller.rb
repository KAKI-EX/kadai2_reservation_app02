class HomeController < ApplicationController

  def index
    # user_signed_in?: ログイン済みの場合はtrueを返す。
    # current_user: ログイン済みの場合はログインユーザーを返す。
    # ログイン済みの場合、ログインユーザーのidをログに書き込む。
    if user_signed_in?
      logger.debug current_user.id
    end
  end
end
