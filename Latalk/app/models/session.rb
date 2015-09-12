class Session < ActiveRecord::Base
	belongs_to :user
	validates :user_name, presence: true
	
	def self.most_recent
    	order('created_at DESC').limit(1).first
 	end
end
