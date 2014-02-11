class AddCoinsAndXpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coins, :integer
    add_column :users, :xp, :integer
  end
end
