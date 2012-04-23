class User < ActiveRecord::Base
  #accessible attributes aka can be editted by users
  attr_accessor :password
  attr_accessible :user_name, :email, :password, :password_confirmation

  email_regex = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  validates :user_name, :presence => true,
  						:length => { :maximum => 50 },
  						:uniqueness => { :case_sensitive => false }

  validates :email, :presence => true,
  					:format => { :with => email_regex },
  					:uniqueness => { :case_sensitive => false }

  validates :password, :presence => true,
  					   :confirmation => true,
  					   :length => { :within => 6..40 }

  before_save :encrypt_password

  #this exists to compare submitted passwords to encrypted passwords becuase encyption methods are private
  def has_password?(submitted_password)
  	encrypted_password == encrypt(submitted_password)
  end

  #authenticate the user (using their email and submitted password)
  def self.authenticate(email, submitted_password)
  	user = find_by_email(email)
  	return nil if user.nil?
  	return user if user.has_password?(submitted_password)
  end

  #authenticate the user's salt against the cookie created when they login
  def self.authenticate_with_salt(id, cookie)
    user = find_by_id(id)

    #if the user is valid and the salt is equal to the cookie, return the user
    #else return nil (invalid salt/cookie combo)
    (user && user.salt == cookie) ? user : nil
  end

  private
  	#the following are all private methods, the user should never have access to them

  	def encrypt_password
  		#check the users encrypted password (in the db) against the submitted (and encrypted) password
  		self.salt = make_salt if new_record? #only create a salt if the user is a new user
  		self.encrypted_password = encrypt(password)
  	end

  	def encrypt(string)
  		secure_hash("#{salt}--#{string}")
  	end

  	def make_salt
  		#each user has a unique salt based off a timestamp
  		secure_hash("#{Time.now.utc}--#{password}")
  	end

  	def secure_hash(string)
  		Digest::SHA2.hexdigest(string)
  	end
end

# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  user_name  :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

