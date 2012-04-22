class UsersController < ApplicationController

  def new
  	@user = User.new
  	@title = "Sign Up"  	
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		#saved!
  	else
  		@title = "Sign Up"
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  	@title = @user.user_name
  end

end
