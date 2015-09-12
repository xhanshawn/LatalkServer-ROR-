class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :messages, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_secure_password
end
