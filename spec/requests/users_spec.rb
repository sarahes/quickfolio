require 'spec_helper'

describe "Users" do
  
  describe "signup" do

  	describe "failure" do

  		it "should not make a new user" do
  		  	lambda do
	  			visit signup_path
	  			fill_in "User name", 		:with => ""
	  			fill_in "Email",			:with => ""
	  			fill_in "Password",			:with => ""
	  			fill_in "Password confirmation",		:with => ""
	  			click_button
	  			response.should render_template('users/new')
	  			response.should have_selector("div.errors")
  		  	end.should_not change(User, :count)
  		end

  	end #end describe failure

  	describe "success" do

  		it "should make a new user" do
  			lambda do
  				visit signup_path
	  			fill_in "User name", 		:with => "Example User"
	  			fill_in "Email",			:with => "user@test.com"
	  			fill_in "Password",			:with => "password"
	  			fill_in "Password confirmation",		:with => "password"
	  			click_button
	  			response.should have_selector("p.flash.success", :content => "You have successfully signed up")
	  			response.should render_template('users/show')
	  		end.should change(User, :count).by(1)
	  	end

	end #end describe success

  end
end
