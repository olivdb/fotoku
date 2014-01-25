class AddExtraCreditToQuests < ActiveRecord::Migration
  def change
  	add_column :quests, :extra_credit_description, :string
  end
end
