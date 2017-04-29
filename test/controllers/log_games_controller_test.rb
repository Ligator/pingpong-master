require 'test_helper'

class LogGamesControllerTest < ActionController::TestCase
  setup do
    @log_game = log_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:log_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create log_game" do
    assert_difference('LogGame.count') do
      post :create, log_game: { date_payed: @log_game.date_payed, opponent: @log_game.opponent, their_socer: @log_game.their_socer, your_score: @log_game.your_score }
    end

    assert_redirected_to log_game_path(assigns(:log_game))
  end

  test "should show log_game" do
    get :show, id: @log_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @log_game
    assert_response :success
  end

  test "should update log_game" do
    patch :update, id: @log_game, log_game: { date_payed: @log_game.date_payed, opponent: @log_game.opponent, their_socer: @log_game.their_socer, your_score: @log_game.your_score }
    assert_redirected_to log_game_path(assigns(:log_game))
  end

  test "should destroy log_game" do
    assert_difference('LogGame.count', -1) do
      delete :destroy, id: @log_game
    end

    assert_redirected_to log_games_path
  end
end
