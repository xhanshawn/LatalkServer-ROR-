class AddDislikeToComment < ActiveRecord::Migration
  def change
    add_column :comments, :dislike, :boolean, :default => false
  end
end
