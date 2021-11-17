class User < ApplicationRecord
    before_create :confirmation_token
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

    def email_activate
        self.email_confirmed = true
        self.confirm_token = nil
        save!(:validate => false)
    end

    private
    def confirmation_token
        if self.confirm_token.blank?
            self.confirm_token = SecureRandom.urlsafe_base64.to_s
        end
    end
end

