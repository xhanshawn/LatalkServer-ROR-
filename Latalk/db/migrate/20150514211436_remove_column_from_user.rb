class RemoveColumnFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :user
  end
end
