class AddAttachmentPhotoToSubmissions < ActiveRecord::Migration
  def self.up
    change_table :submissions do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :submissions, :photo
  end
end
