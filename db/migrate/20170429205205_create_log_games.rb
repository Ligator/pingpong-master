class CreateLogGames < ActiveRecord::Migration
  def change
    create_table :log_games do |t|
      t.date :date_payed
      t.integer :first_opponent_id
      t.integer :second_opponent_id
      t.integer :your_score
      t.integer :their_socer

      t.timestamps null: false
    end
  end
end
