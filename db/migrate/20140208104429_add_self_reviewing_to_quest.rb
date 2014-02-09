class AddSelfReviewingToQuest < ActiveRecord::Migration
  def change
    add_column :quests, :self_reviewable, :boolean
    add_column :quests, :self_review_range, :integer
  end
end
