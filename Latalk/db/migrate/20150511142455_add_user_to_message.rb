class AddUserToMessage < ActiveRecord::Migration
  def change
    add_reference :messages, :message, index: true
    add_foreign_key :messages, :messages
  end
end
