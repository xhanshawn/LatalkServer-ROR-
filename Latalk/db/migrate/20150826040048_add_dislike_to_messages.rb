class AddDislikeToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :dislike, :integer, :default => 0
  end
end
