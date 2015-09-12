class AddNextPuzzleToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :next_puzzle, :integer
  end
end
