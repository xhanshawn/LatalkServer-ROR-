class RenameNextPuzzle < ActiveRecord::Migration
  def change
  	rename_column :messages, :next_puzzle, :race_num
  	add_column :messages, :start_id, :integer
  end
end
