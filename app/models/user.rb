class User < ActiveRecord::Base
  #accessible attributes aka can be editted by users
  attr_accessible :user_name, :email 

  email_regex = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  validates :user_name, :presence => true,
  						:length => { :maximum => 50 },
  						:uniqueness => { :case_sensitive => false }

  validates :email, :presence => true,
  					:format => { :with => email_regex },
  					:uniqueness => { :case_sensitive => false }
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

