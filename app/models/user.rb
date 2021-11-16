class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@columbia.edu/i.freeze
    validates_uniqueness_of :username
    validates :username, presence: true
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    scope :all_except, ->(user) { where.not(id: user) }
    has_many :messages
    validates :password, presence: true
    # has_secure_password
    validates :password, confirmation: { case_sensitive: true }
    after_create_commit { broadcast_append_to "users" }
end

