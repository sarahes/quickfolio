require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a Home page at '/'" do
	get '/'
	response.should have_selector('title', :content => "Home")
  end

  it "should have an About page at '/about'" do
	get '/'
	response.should have_selector('title', :content => "About")
  end

  it "should have a Contact page at '/contact'" do
	get '/'
	response.should have_selector('title', :content => "Contact")
  end
 
end