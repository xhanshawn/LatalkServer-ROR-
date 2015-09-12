class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :user_name
      t.timestamp :logout_by

      t.timestamps null: false
    end
  end
end
