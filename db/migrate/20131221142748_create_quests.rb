class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :title
      t.string :photo_url
      t.integer :owner_id

      t.timestamps
    end
  end
end
