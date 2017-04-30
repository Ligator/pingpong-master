class HomeController < ApplicationController
  def index
    users_with_score = User.where.not(score: nil).order(score: :desc)
    users_without_score = User.where(score: nil)
    @users = users_with_score + users_without_score
  end

  def history
  end

  def log
  end
end
