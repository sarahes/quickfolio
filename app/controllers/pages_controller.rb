class PagesController < ApplicationController
	
  def home
  	@title = "Home"

    @users = User.find(:all, :order => "id desc", :limit => 5)
  end

  def about
  	@title = "About"
  end

  def contact
  	@title = "Contact"
  end

end
