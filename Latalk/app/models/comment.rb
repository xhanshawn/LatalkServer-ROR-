class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  validates :user_id, :message_id, presence: true, numericality: { only_integer: true }
  validate :validate_user_id
  validate :validate_message_id
private 
  # validate two ids in database
  def validate_user_id
  	errors.add(:user_id, "is invalid" ) unless User.exists?(self.user_id)
  end
  def validate_message_id
  	errors.add(:message_id, "is invalid") unless Message.exists?(self.message_id)
  end
end
