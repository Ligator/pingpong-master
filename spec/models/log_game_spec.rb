require "rails_helper"

describe LogGame do
  def valid_params(options = {})
    {
      first_opponent_id: 101,
      second_opponent_id: 100,
      your_score: 21,
      their_socer: 17,
      date_payed: Date.today
    }.merge(options)
  end

  it "should be valid with correct params" do
    @log_game = LogGame.new(valid_params)
    expect(@log_game.valid?).to be_truthy
  end

  describe "#overage_points?" do
    it "should return false when one score is greater than 21" do
      @log_game = LogGame.new(valid_params(your_score: 28))
      expect(@log_game.save).to be_falsey
    end
  end

  describe "#validate_margin_of_two_points" do
    it "should return false when one score is greater than 21" do
      @log_game = LogGame.new(valid_params(your_score: 20, their_socer: 19))
      expect(@log_game.save).to be_falsey
    end
  end

  describe "validating precense" do
    it "of first_opponent_id" do
      @log_game = LogGame.new(valid_params(first_opponent_id: nil))
      expect(@log_game.valid?).to be_falsey
    end

    it "of second_opponent_id" do
      @log_game = LogGame.new(valid_params(second_opponent_id: nil))
      expect(@log_game.valid?).to be_falsey
    end

    it "of your_score" do
      @log_game = LogGame.new(valid_params(your_score: nil))
      expect(@log_game.valid?).to be_falsey
    end

    it "of their_socer" do
      @log_game = LogGame.new(valid_params(their_socer: nil))
      expect(@log_game.valid?).to be_falsey
    end

    it "of date_payed" do
      @log_game = LogGame.new(valid_params(date_payed: nil))
      expect(@log_game.valid?).to be_falsey
    end
  end
end
