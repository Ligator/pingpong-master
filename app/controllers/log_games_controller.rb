class LogGamesController < ApplicationController
  before_action :set_log_game, only: [:show, :edit, :update, :destroy]

  def index
    @log_games = current_user.log_games
  end

  def new
    @log_game = LogGame.new
  end

  def create
    @log_game = LogGame.new(log_game_params)
    @log_game.first_opponent_id = current_user.id

    if @log_game.save
      redirect_to log_games_path, notice: 'Log game was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @log_game.destroy
    redirect_to log_games_url, notice: 'Log game was successfully destroyed.'
  end

  private
    def set_log_game
      @log_game = LogGame.find(params[:id])
    end

    def log_game_params
      params.require(:log_game).permit(:date_payed, :second_opponent_id, :your_score, :their_socer)
    end
end
