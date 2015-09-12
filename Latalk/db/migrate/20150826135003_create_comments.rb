class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.boolean :like
      t.belongs_to :user, index: true
      t.belongs_to :message, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :messages
  end
end
