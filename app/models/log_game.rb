class LogGame < ActiveRecord::Base
  validates :first_opponent_id, :date_payed, presence: true
  validates :second_opponent_id, presence: { message: "You must select an opponent." }
  validates :your_score, presence: true, numericality: { only_integer: true }
  validates :their_socer, presence: true, numericality: { only_integer: true }
  before_create :overage_points?
  before_create :validate_margin_of_two_points

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
end
