class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message_type
      t.text :content
      t.float :longitude, precision: 3, scale: 6
      t.float :latitude, precision: 3, scale: 6
      t.decimal :hold_time, precision: 16, scale: 0

      t.timestamps null: false
    end
  end
end
