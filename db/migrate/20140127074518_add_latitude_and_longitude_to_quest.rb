class AddLatitudeAndLongitudeToQuest < ActiveRecord::Migration
  def change
    add_column :quests, :latitude, :float
    add_column :quests, :longitude, :float
    #add_column :quests, :latitude, :decimal, { :precision => 10, :scale => 6 }
	#add_column :quests, :longitude, :decimal, { :precision => 10, :scale => 6 }
	add_index :quests, :latitude
	add_index :quests, :longitude
  end
end
