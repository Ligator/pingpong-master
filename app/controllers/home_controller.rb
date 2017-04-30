class HomeController < ApplicationController
  def index
    @users = User.order(score: :desc).limit(10)
  end

  def history
  end

  def log
  end
end
