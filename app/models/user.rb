class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  def opponents
    User.where.not(id: id)
  end

  def log_games
    LogGame.where("first_opponent_id = ? OR second_opponent_id = ?", id, id).order(date_payed: :desc)
  end

  def opponent_in_game(log_game)
    opponent_id = get_opponent_id(log_game)
    User.find(opponent_id)
  end

  def win?(log_game)
    return true if log_game.first_opponent_id == id && log_game.your_score > log_game.their_socer
    return true if log_game.second_opponent_id == id && log_game.your_score < log_game.their_socer
    false
  end

  def games_played
    log_games.count
  end

private

  def get_opponent_id(log_game)
    return log_game.first_opponent_id if log_game.first_opponent_id != id
    log_game.second_opponent_id
  end
end
