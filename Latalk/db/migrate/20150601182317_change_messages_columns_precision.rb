class ChangeMessagesColumnsPrecision < ActiveRecord::Migration
  def change
  	change_column :messages, :longitude, :float, precision: 6, scale: 9
  	change_column :messages, :latitude, :float, precision: 6, scale: 9
  end
end
