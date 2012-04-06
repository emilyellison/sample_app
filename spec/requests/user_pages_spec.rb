require 'spec_helper'

describe "User Pages" do
  subject { page }
  
  describe "Profile Page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_selector('h1',     text: user.name) }
    it { should have_selector('title',  text: user.name) }
  end
    
  describe "SignUp Page" do
    before { visit signup_path }
  
    it { should have_selector('h1',     text: 'Sign Up') }
    it { should have_selector('title',  text: full_title('Sign Up')) }
  end 
  
  describe "SignUp" do
    before { visit signup_path }
    
    describe "with invalid information" do 
      it "should not create a user" do
        expect { click_button "Create my account" }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name", with: "Example McTest"
        fill_in "Email", with: "example@test.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end
      
      it "should create a user" do
        expect do
          click_button "Create my account"
        end.to change(User, :count).by(1)
      end
    end
  end
end