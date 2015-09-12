class RemoveForeignKeyUser < ActiveRecord::Migration
  def change
  	remove_foreign_key :users, column: :user_id
  end
end
