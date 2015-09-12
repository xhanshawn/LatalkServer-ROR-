class AddUserToSessions < ActiveRecord::Migration
  def change
    add_reference :sessions, :user, index: true
  end
end
