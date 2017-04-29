require "rails_helper"

describe User do
  before(:each) do
    @user = User.create(email: "user@example.com", password: "12345678", password_confirmation: "12345678")
  end

  describe "#log_games" do
    before do
      @log_game1 = LogGame.create(first_opponent_id: @user.id,
                                  second_opponent_id: 100,
                                  your_score: 21,
                                  their_socer: 17,
                                  date_payed: Date.today)
      @log_game2 = LogGame.create(first_opponent_id: 101,
                                  second_opponent_id: 100,
                                  your_score: 21,
                                  their_socer: 17,
                                  date_payed: Date.today)
    end

    it "should get log_games for current user" do
      expect(@user.log_games).to eq([@log_game1])
    end
  end

  describe "#opponents" do
    before do
      @user2 = User.create(email: "user2@example.com", password: "12345678", password_confirmation: "12345678")
      @user3 = User.create(email: "user3@example.com", password: "12345678", password_confirmation: "12345678")
    end

    it "should get log_games for current user" do
      expect(@user.opponents.sort).to eq([@user2, @user3].sort)
    end
  end

  describe "#opponent_in_game" do
    before do
      @user2 = User.create(email: "user2@example.com", password: "12345678", password_confirmation: "12345678")
      @user3 = User.create(email: "user3@example.com", password: "12345678", password_confirmation: "12345678")
      @log_game1 = LogGame.create(first_opponent_id: @user.id,
                                  second_opponent_id: @user2.id,
                                  your_score: 21,
                                  their_socer: 17,
                                  date_payed: Date.today)
    end

    it "should get log_games for first_opponent" do
      expect(@user.opponent_in_game(@log_game1)).to eq(@user2)
    end

    it "should get log_games for second_opponent" do
      expect(@user2.opponent_in_game(@log_game1)).to eq(@user)
    end
  end

  describe "#win?" do
    before do
      @user2 = User.create(email: "user2@example.com", password: "12345678", password_confirmation: "12345678")
      @log_game1 = LogGame.create(first_opponent_id: @user.id,
                                  second_opponent_id: @user2.id,
                                  your_score: 21,
                                  their_socer: 17,
                                  date_payed: Date.today)
    end

    it "should be true when the user won" do
      expect(@user.win?(@log_game1)).to be_truthy
    end

    it "should be true when the user won" do
      expect(@user2.win?(@log_game1)).to be_falsey
    end
  end
end
