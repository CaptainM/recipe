class User < ActiveRecord::Base
	validates_presence_of :name, :username
	validates_uniqueness_of :username
	validates :name, :numericality => false
	has_secure_password

end