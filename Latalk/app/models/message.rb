class Message < ActiveRecord::Base
	has_many :comment, dependent: :destroy
	belongs_to :user
	validates :message_type, :content, :user_name, presence: true
	validates :content, length: {
		# minimum:10,
		maximum: 500,
		# too_short: "",
		too_long: "must have at most 500 characters"
	}
	
	validates :longitude, numericality: {
		less_than_or_equal_to: 181.000000,
		greater_than_or_equal_to: -180.000000
	}
	validates :latitude, numericality: {
		less_than_or_equal_to: 91.000000,
		greater_than_or_equal_to: -90.000000
	}

	validates :hold_time, numericality: {
		greater_than_or_equal_to: 0
	}

	mount_base64_uploader :image, ImageUploader

end
