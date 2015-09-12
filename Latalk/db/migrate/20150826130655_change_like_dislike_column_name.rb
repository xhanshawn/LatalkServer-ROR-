class ChangeLikeDislikeColumnName < ActiveRecord::Migration
  def change
  	change_table :messages do |t|
  		t.rename :like, :like_num
  		t.rename :dislike, :dislike_num
  	end
  end
end
