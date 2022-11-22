class User < ApplicationRecord

    before_save {self.email = email.downcase}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, presence: true, length: {minimum: 3, maximum: 125}
	validates :phonenumber, presence: true, numericality: { only_integer: true }, length: {is: 10}
	validates :email, presence: true, 
					  length: {maximum: 125}, 
					  uniqueness: { case_sensitive: false }, 
					  format: {with: VALID_EMAIL_REGEX}

	has_many :hotels, dependent: :destroy
	has_many :reviews, dependent: :destroy
	has_secure_password
end