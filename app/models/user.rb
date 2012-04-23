class User < ActiveRecord::Base
  #accessible attributes aka can be editted by users
  attr_accessor :password
  attr_accessible :user_name, :email, :password, :password_confirmation, :f_name,
                  :l_name, :city, :state, :phone, :svad_major, :class_stading, :twitter_url, 
                  :facebook_url, :linkedin_url, :forrst_user_name, :website, :about

  email_regex = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  validates :user_name, :presence => true,
  						:length => { :maximum => 50 },
  						:uniqueness => { :case_sensitive => false }

  validates :email, :presence => true,
  					:format => { :with => email_regex },
  					:uniqueness => { :case_sensitive => false }

  validates :password, :presence => true,
  					   :confirmation => true,
  					   :length => { :within => 6..40 },
               :on => :create

  #only validate the following on update
  validate :f_name, :presence => true,
                    :length => { :maximum => 50 },
                    :on => :update

  validate :l_name, :presence => true,
                    :length => { :maximum => 50 },
                    :on => :update

  validate :svad_major, :presence => true,
                    :length => { :maximum => 50 },
                    :on => :update

  validate :class_stading, :presence => true,
                    :length => { :maximum => 50 },
                    :on => :update

  #the following fields are all optional so allow blanks
  validates_length_of :city, :maximum => 50, :allow_blank => true
  validates_length_of :state, :maximum => 50, :allow_blank => true
  validates_length_of :phone, :maximum => 50, :allow_blank => true #I probably should do some other kind of validation on phone but for not just length
  validates_length_of :twitter_url, :maximum => 50, :allow_blank => true
  validates_length_of :facebook_url, :maximum => 50, :allow_blank => true
  validates_length_of :linkedin_url, :maximum => 50, :allow_blank => true
  validates_length_of :forrst_user_name, :maximum => 50, :allow_blank => true
  validates_length_of :website, :maximum => 50, :allow_blank => true

  validate :check_website_url #if a url is entered, must have http or https   


  before_save :encrypt_password

  #using the make_permalink gem here to create pretty urls for users
  #url can be /username instead of /users/id
  make_permalink :user_name

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

  #validate that the url they enter begins with http or https
  def check_website_url
    if !self.website.blank?
      validates_format_of :website, :with => URI::regexp(%w(http https)), :message => "invalid - should begin with \"http://\""  
    end
  end

  def to_param
    permalink
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