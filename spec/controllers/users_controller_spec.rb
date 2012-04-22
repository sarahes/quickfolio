require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end    

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end 

    it "should have the right title" do
     get :show, :id => @user
     response.should have_selector("title", :content => @user.user_name)
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h2", :content => @user.user_name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h2>img", :class => "gravatar")
    end

  end #end describe show

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end
 

    it "should have the right title" do
    	get 'new'
    	response.should have_selector("title", :content => "Sign Up")
    end
  end #end describe new

  describe "POST 'create'" do

    describe "failure" do

      #before each test we want to create a user with all blank fields (i.e. when a form is submitted with no fields filled out)
      before(:each) do 
        @attr = { :user_name => '', :email => '', :password => '', :password_confirmation => '' }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr          
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr 
        response.should have_selector("title", :content => "Sign Up")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end

    end #end describe failure
  end #end describe post create
end
