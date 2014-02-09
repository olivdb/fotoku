class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.integer :quest_id
      t.boolean :has_extra_credit
      t.integer :status, default: 0
      t.timestamp :submitted_at
      t.integer :ranking
      t.integer :difficulty
      t.integer :xp
      t.integer :coins_earned
      t.integer :extra_credit_coins_earned

      t.timestamps
    end
  end
end
