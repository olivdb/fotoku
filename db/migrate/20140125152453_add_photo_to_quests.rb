class AddPhotoToQuests < ActiveRecord::Migration
  def self.up
    add_attachment :quests, :photo
  end

  def self.down
    remove_attachment :quests, :photo
  end
end
