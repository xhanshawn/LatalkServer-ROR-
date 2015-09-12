class AddLikeToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :like, :integer, :default => 0
  end
end
