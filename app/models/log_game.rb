class LogGame < ActiveRecord::Base
  validates :first_opponent_id, :date_payed, presence: true
  validates :second_opponent_id, presence: { message: "You must select an opponent." }
  validates :your_score, presence: true, numericality: { only_integer: true }
  validates :their_socer, presence: true, numericality: { only_integer: true }
  before_create :overage_points?
  before_create :validate_margin_of_two_points
  after_create :update_scores

  def overage_points?
    scores = [your_score, their_socer]
    if scores.max > 21
      errors.add(:base, "The game should be to 21 points.")
      return false
    end
    true
  end

  def validate_margin_of_two_points
    scores = [your_score, their_socer].sort
    if scores[1] - scores[0] < 2
      errors.add(:base, "Each game needs to be won by a two point margin.")
      return false
    end
    true
  end

  def update_scores
    player1 = User.find(first_opponent_id)
    player2 = User.find(second_opponent_id)
    if player1.win?(self)
      calculate_score(player1, player2, your_score - their_socer)
    else
      calculate_score(player2, player1, their_socer - your_score)
    end
  end

  def calculate_score(player1, player2, result, k_value = 32)
    player1_rating = player1.score.to_i
    player2_rating = player2.score.to_i
    player1_result = result
    player2_result = 1 - result

    player1_expectation = 1/(1+10**((player2_rating - player1_rating)/400.0))
    player2_expectation = 1/(1+10**((player1_rating - player2_rating)/400.0))

    player1_new_rating = player1_rating + (k_value*(player1_result - player1_expectation))
    player2_new_rating = player2_rating + (k_value*(player2_result - player2_expectation))

    player1.update(score: player1_new_rating.round) if player1_new_rating > 0
    player2.update(score: player2_new_rating.round) if player2_new_rating > 0
  end
end
