require 'spec_helper'

describe User do
  
  before (:each) do
  	@attr = {
  		:user_name => "Test User", 
  		:email => "user@example.com",
  		:password => "testpassword",
  		:password_confirmation => "testpassword"
  	}
  end

  it "should create a new instance given valid attributes" do
  	User.create!(@attr)
  end

  #validate length of user name and e-mail address
  it "should require a name" do
  	no_user_name = User.new(@attr.merge(:user_name => ""))
  	no_user_name.should_not  be_valid
  end

  it "should require an email" do
  	no_email = User.new(@attr.merge(:email => ""))
  	no_email.should_not be_valid
  end

  #validate length of user name
  it "should reject user names that are too long" do
    long_name = "a" * 51
    long_user_name = User.new(@attr.merge(:user_name => long_name))
    long_user_name.should_not be_valid
  end

  #validate e-mail addresses
  it "should accept valid email addresses" do
  	#an array of e-mails to test
  	addresses = %w[user@test.com THE_USER@test.ucf.com first.last@test.com]

  	#loop through the array to test each email and make sure it's valid
  	addresses.each do |address|
  	  valid_email = User.new(@attr.merge(:email => address))
  	  valid_email.should be_valid
  	end

  end

  it "should reject invalid email addresses" do
    #an array of e-mails to test
  	addresses = %w[user@test,com THE_USER.com first.last@test]

  	#loop through the array to test each email and make sure it's valid
  	addresses.each do |address|
  	  valid_email = User.new(@attr.merge(:email => address))
  	  valid_email.should_not be_valid
  	end

  end

  #check for duplicate user names or email addresses
  it "should reject duplicate user names" do
  	User.create!(@attr)
  	user_with_duplicate_name = User.new(@attr)
  	user_with_duplicate_name.should_not be_valid
  end

  it "should reject duplicate email addresses" do
  	User.create!(@attr)
  	user_with_duplicate_email = User.new(@attr)
  	user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
  	upcased_email = @attr[:email].upcase
  	User.create!(@attr.merge(:email => upcased_email))
  	user_with_duplicate_email = User.new(@attr)
  	user_with_duplicate_email.should_not be_valid
  end

  it "should reject user names identical up to case" do
  	upcased_user_name = @attr[:user_name].upcase
  	User.create!(@attr.merge(:user_name => upcased_user_name))
  	user_with_duplicate_name = User.new(@attr)
  	user_with_duplicate_name.should_not be_valid
  end

  #password validations
  describe "password validations" do

  	it "should require a password" do
  		User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
  	end

  	it "should require a matching password confirmation" do
  		User.new(@attr.merge(:password_confirmation => "notpassword")).should_not be_valid
  	end

  	it "should rejeect short passwords" do
  		short_password = "a" * 5
  		hash = @attr.merge(:password => short_password, :password_confirmation => short_password)
  		User.new(hash).should_not be_valid
  	end

  	it "should reject long passwords" do
  		long_password = "a" * 41
  		hash = @attr.merge(:password => long_password, :password_confirmation => long_password)
  		User.new(hash).should_not be_valid
  	end

  end

  #validate password encryption
  describe "password encryption" do 

 	before(:each) do
 		@user = User.create!(@attr)
 	end

 	it "should have an encrypted password attribute" do
 		@user.should respond_to(:encrypted_password)
 	end

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

